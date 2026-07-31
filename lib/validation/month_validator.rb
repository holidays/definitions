require_relative 'error'

module Definitions
  module Validation
    class Month
      VALID_YEAR_RANGE_SELECTORS = ["until", "from", "limited", "between"]

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

        raise Errors::InvalidMonth.new("A holiday in month #{month} is missing a 'name', received: #{month_def}") if name.nil? || name.empty?

        validate_regions!(month, name, month_def['regions'])
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
