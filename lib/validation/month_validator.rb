require_relative 'error'

module Definitions
  module Validation
    class Month
      VALID_YEAR_RANGE_SELECTORS = ["until", "from", "limited", "between"]
      VALID_TYPES = ["informal"]
      VALID_WEEKS = [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5]
      REGION_FORMAT = /\A[a-z0-9_]+\z/
      UNSAFE_NAME = /\#\{|`|[[:cntrl:]]/

      def call(months)
        raise Errors::NoMonths.new("Months is required, received: '#{months}'") if months.nil? || months.empty?

        months.each do |month, month_defs|
          raise Errors::InvalidMonth.new("Month key must be an integer, received: '#{month}'") unless month.is_a?(Integer)
          raise Errors::InvalidMonth.new("Month key must be between 0 and 12, received: '#{month}'") if month < 0 || month > 12

          month_defs.each do |month_def|
            validate_month_def!(month, month_def)
          end
        end

        true
      end

      private

      def validate_month_def!(month, month_def)
        name = month_def['name']

        raise Errors::InvalidMonth.new("A holiday in month #{month} is missing a 'name', received: #{month_def}") if name.nil? || name == ""
        raise Errors::InvalidMonth.new("A holiday in month #{month} must have a string 'name', received: #{name.inspect}") unless name.is_a?(String)
        raise Errors::InvalidMonth.new("Holiday #{name.inspect} in month #{month} name must not contain '\#{', backticks or control characters") if name.match?(UNSAFE_NAME)

        validate_fields!(month, name, month_def)
        validate_regions!(month, name, month_def['regions'])
        validate_excluded_regions!(month, name, month_def['regions'], month_def['excluded_regions']) if month_def.key?("excluded_regions")
        validate_year_ranges!(month, name, month_def['year_ranges']) if month_def.key?("year_ranges")
      end

      def validate_regions!(month, name, regions)
        if regions.nil? || regions.empty?
          raise Errors::InvalidRegions.new("#{context(month, name)} must contain at least one region, received: #{regions.inspect}")
        end

        regions.each do |region|
          if region.nil? || region.empty?
            raise Errors::InvalidRegions.new("#{context(month, name)} contains an empty region, received: #{regions.inspect}")
          end

          unless region.to_s.match?(REGION_FORMAT)
            raise Errors::InvalidRegions.new("#{context(month, name)} region '#{region}' must only contain lowercase letters, digits and underscores")
          end
        end
      end

      def validate_fields!(month, name, month_def)
        if month_def.key?("mday") && !(month_def["mday"].is_a?(Integer) && (1..31).cover?(month_def["mday"]))
          raise Errors::InvalidMonth.new("#{context(month, name)} mday must be an integer from 1 to 31, received: #{month_def["mday"].inspect}")
        end

        if month_def.key?("wday") && !(month_def["wday"].is_a?(Integer) && (0..6).cover?(month_def["wday"]))
          raise Errors::InvalidMonth.new("#{context(month, name)} wday must be an integer from 0 to 6, received: #{month_def["wday"].inspect}")
        end

        if month_def.key?("week") && !VALID_WEEKS.include?(month_def["week"])
          raise Errors::InvalidMonth.new("#{context(month, name)} week must be an integer from 1 to 5 or -1 to -5, received: #{month_def["week"].inspect}")
        end

        if month_def.key?("function_modifier") && !month_def["function_modifier"].is_a?(Integer)
          raise Errors::InvalidMonth.new("#{context(month, name)} function_modifier must be an integer, received: #{month_def["function_modifier"].inspect}")
        end

        if month_def.key?("type") && !VALID_TYPES.include?(month_def["type"])
          raise Errors::InvalidMonth.new("#{context(month, name)} type must be one of: #{VALID_TYPES.join(', ')}, received: #{month_def["type"].inspect}")
        end
      end

      def validate_excluded_regions!(month, name, regions, excluded)
        unless excluded.is_a?(Array) && !excluded.empty?
          raise Errors::InvalidRegions.new("#{context(month, name)} excluded_regions must be a non-empty array of regions, received: #{excluded.inspect}")
        end

        excluded.each do |region|
          unless region.is_a?(String) && !region.empty?
            raise Errors::InvalidRegions.new("#{context(month, name)} excluded_regions contains an empty or non-string region, received: #{excluded.inspect}")
          end

          unless region.match?(REGION_FORMAT)
            raise Errors::InvalidRegions.new("#{context(month, name)} excluded_regions entry '#{region}' must only contain lowercase letters, digits and underscores")
          end

          if regions.include?(region)
            raise Errors::InvalidRegions.new("#{context(month, name)} excluded_regions entry '#{region}' also appears in regions, received: #{regions.inspect}")
          end

          unless regions.any? { |parent| region.start_with?("#{parent}_") }
            raise Errors::InvalidRegions.new("#{context(month, name)} excluded_regions entry '#{region}' must be a subregion of one of its regions, received: #{regions.inspect}")
          end
        end
      end

      def validate_year_ranges!(month, name, year_ranges)
        unless year_ranges.is_a?(Hash) && year_ranges.size == 1
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges only supports a single selector at this time, received: #{year_ranges.inspect}")
        end

        selector = year_ranges.keys.first
        value = year_ranges[selector]

        unless VALID_YEAR_RANGE_SELECTORS.include?(selector.to_s)
          raise Errors::InvalidMonth.new("#{context(month, name)} has an invalid year_ranges selector '#{selector}'. Valid selectors are: #{VALID_YEAR_RANGE_SELECTORS.join(', ')}")
        end

        case selector.to_s
        when "until", "from"
          unless value.is_a?(Integer)
            raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.#{selector} must contain a single 'year' integer, ex. 2018, received: #{value.inspect}")
          end
        when "limited"
          validate_limited!(month, name, value)
        when "between"
          validate_between!(month, name, value)
        end
      end

      def validate_limited!(month, name, value)
        unless value.is_a?(Array)
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.limited must contain an array of 'year' integers, ex. [2018], received: #{value.inspect}")
        end

        value.each do |year|
          unless year.is_a?(Integer)
            raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.limited must contain only 'year' integers, ex. [2018], received: '#{year}'")
          end
        end
      end

      def validate_between!(month, name, value)
        unless value.is_a?(Hash) && value.key?("start") && value.key?("end")
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.between must contain both a 'start' and 'end' key, received: #{value.inspect}")
        end

        unless value["start"].is_a?(Integer)
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.between.start must contain a single 'year' integer, ex. 2018, received: #{value["start"].inspect}")
        end

        unless value["end"].is_a?(Integer)
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.between.end must contain a single 'year' integer, ex. 2018, received: #{value["end"].inspect}")
        end

        if value["end"] < value["start"]
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.between.end cannot be before the start value, received start: #{value["start"]}, end: #{value["end"]}")
        end

        if value["end"] == value["start"]
          raise Errors::InvalidMonth.new("#{context(month, name)} year_ranges.between start and end values cannot be the same, received: #{value["start"]}")
        end
      end

      def context(month, name)
        "Holiday '#{name}' in month #{month}"
      end
    end
  end
end
