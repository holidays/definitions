require_relative 'error'

module Definitions
  module Validation
    class RegionNames
      # :vi is a non-standard gem code for Vietnam (ISO 3166-1 VI = US Virgin Islands).
      # Skip ISO validation until the breaking rename :vi -> :vn is made.
      # See: https://github.com/holidays/definitions/issues/177
      NON_ISO_REGIONS = %w[vi].freeze

      def initialize(iso_names = {})
        @iso_names = iso_names
      end

      def call(region_names, months)
        validate_presence!(region_names)
        validate_coverage!(region_names, months)
        validate_iso_names!(region_names)
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

      def validate_iso_names!(region_names)
        mismatches = []

        region_names.each do |code, name|
          code_str = code.to_s
          next if NON_ISO_REGIONS.include?(code_str)

          expected = @iso_names[code_str]
          next if expected.nil?

          mismatches << "#{code}: expected '#{expected}' but got '#{name}'" unless name == expected
        end

        unless mismatches.empty?
          raise Errors::InvalidRegionNames.new(
            "region_names has incorrect ISO names:\n#{mismatches.join("\n")}\nSee doc/SYNTAX.md for naming conventions."
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
