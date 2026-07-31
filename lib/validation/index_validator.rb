require_relative 'error'

module Definitions
  module Validation
    class Index
      # Regions that intentionally have no definition file of their own. They exist
      # only to bundle other regions' files together, so the '<region>.yaml' naming
      # rule does not apply to them. Add to this list consciously: a typo'd region
      # key is otherwise indistinguishable from a new aggregate.
      AGGREGATE_REGIONS = [
        'Europe',
        'NorthAmerica',
        'Scandinavia',
        'SouthAmerica',
      ].freeze

      VALID_FILE_NAME = /\A[a-z0-9_]+\.yaml\z/

      def call(index, definition_files)
        defs = validate_structure!(index)

        validate_file_names!(defs)
        validate_all_files_indexed!(defs, definition_files)
        validate_all_indexed_files_exist!(defs, definition_files)
        validate_region_file_names!(defs)

        true
      end

      private

      def validate_structure!(index)
        raise Errors::InvalidIndex.new("index must be a hash, received: '#{index}'") unless index.is_a?(Hash)

        defs = index['defs']

        raise Errors::InvalidIndex.new("index is missing a 'defs' entry") if defs.nil?
        raise Errors::InvalidIndex.new("index 'defs' must be a hash, received: '#{defs}'") unless defs.is_a?(Hash)
        raise Errors::InvalidIndex.new("index 'defs' must not be empty") if defs.empty?

        defs.each do |region, files|
          unless files.is_a?(Array) && !files.empty?
            raise Errors::InvalidIndex.new("index entry for '#{region}' must be a non-empty array, received: '#{files}'")
          end
        end

        defs
      end

      def validate_file_names!(defs)
        invalid = indexed_files(defs).reject { |file| file =~ VALID_FILE_NAME }

        unless invalid.empty?
          raise Errors::InvalidIndex.new(
            "index lists files with invalid names: #{invalid.sort.join(', ')}\n" \
            "Definition file names must be lowercase and end in '.yaml', e.g. 'us.yaml' or 'be_fr.yaml'."
          )
        end
      end

      def validate_all_files_indexed!(defs, definition_files)
        missing = definition_files - indexed_files(defs)

        unless missing.empty?
          raise Errors::InvalidIndex.new(
            "definition files are not listed in index.yaml: #{missing.sort.join(', ')}\n" \
            "Please add them to the appropriate region entry in index.yaml."
          )
        end
      end

      def validate_all_indexed_files_exist!(defs, definition_files)
        missing = indexed_files(defs) - definition_files

        unless missing.empty?
          raise Errors::InvalidIndex.new(
            "index.yaml lists files that do not exist: #{missing.sort.join(', ')}"
          )
        end
      end

      def validate_region_file_names!(defs)
        mismatches = defs.reject { |region, files|
          AGGREGATE_REGIONS.include?(region) || files.include?(expected_file_name(region))
        }.keys

        unless mismatches.empty?
          raise Errors::InvalidIndex.new(
            "index entries do not list their own definition file: " \
            "#{mismatches.sort.map { |r| "#{r} (expected '#{expected_file_name(r)}')" }.join(', ')}\n" \
            "A region must list '<region>.yaml' unless it is an aggregate of other regions."
          )
        end
      end

      def expected_file_name(region)
        "#{region.downcase}.yaml"
      end

      def indexed_files(defs)
        defs.values.flatten.uniq
      end
    end
  end
end
