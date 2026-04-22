require_relative 'error'

module Definitions
  module Validation
    class RegionNames
      def call(region_names, months)
        validate_presence!(region_names)
        validate_coverage!(region_names, months)
      end

      private

      def validate_presence!(region_names)
        raise Errors::InvalidRegionNames.new("region_names is required") if region_names.nil?
        raise Errors::InvalidRegionNames.new("region_names must be a hash, received: '#{region_names}'") unless region_names.is_a?(Hash)
        raise Errors::InvalidRegionNames.new("region_names must not be empty") if region_names.empty?
      end

      def validate_coverage!(region_names, months)
        regions_in_months = extract_regions(months)
        region_name_keys = region_names.keys.map(&:to_s)

        missing = regions_in_months - region_name_keys
        extra = region_name_keys - regions_in_months

        unless missing.empty?
          raise Errors::InvalidRegionNames.new(
            "region_names is missing entries for regions: #{missing.sort.join(', ')}"
          )
        end

        unless extra.empty?
          raise Errors::InvalidRegionNames.new(
            "region_names has entries for regions not found in months: #{extra.sort.join(', ')}"
          )
        end

        true
      end

      def extract_regions(months)
        months.each_with_object([]) do |(_, month_defs), regions|
          month_defs.each do |month_def|
            Array(month_def['regions']).each do |region|
              regions << region.to_s unless region.nil? || region.empty?
            end
          end
        end.uniq
      end
    end
  end
end
