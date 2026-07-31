## encoding: utf-8

require 'yaml'
require 'countries'

require_relative 'error'
require_relative 'definition_validator'
require_relative 'index_validator'
require_relative 'region_names_validator'
require_relative 'custom_method_validator'
require_relative 'month_validator'
require_relative 'test_validator'

definitions_path = '/../../'

module Definitions
  class Validate
    def initialize(path, definition_validator, index_validator)
      @path = path
      @definition_validator = definition_validator
      @index_validator = index_validator
    end

    def call
      path = File.expand_path(File.dirname(__FILE__)) + @path

      index_file = YAML.load(File.open(path + 'index.yaml'))
      definition_files = Dir.glob('*.yaml', base: path) - ['index.yaml']

      begin
        @index_validator.call(index_file, definition_files)
      rescue Definitions::Errors::InvalidIndex => e
        puts "Failed on 'index.yaml', error: #{e}"
        exit 1
      end

      definition_count = 0

      definition_files.each do |item|
        target = path+item

        definition_count += 1

        begin
          definition_file = YAML.load(File.open(target))
          validate!(definition_file)
        rescue Psych::SyntaxError => e
          puts "Failed on file '#{target}', YAML parse error: #{e}"
          puts "This means your YAML is somehow invalid. Test your file on something like yamllint.com to find the issue."
          exit 1
        rescue => e
          puts "Failed on file '#{target}', error: #{e}"
          exit 1
        end
      end

      puts "Success!"
      puts "Definition count: #{definition_count}"
    end

    private

    def validate!(definition)
      raise StandardError unless @definition_validator.call(definition)
    end
  end
end

# Build a flat lookup of region code -> ISO common name for all countries and their
# subdivisions. Injected into RegionNames validator so the validator itself has no
# direct dependency on the countries gem.
iso_names = {}
ISO3166::Country.all.each do |country|
  iso_names[country.alpha2.downcase] = country.common_name
  country.subdivisions.each do |sub_code, sub|
    iso_names["#{country.alpha2.downcase}_#{sub_code.downcase}"] = sub.name.gsub(/ \([a-z]{2,3}\)$/, '')
  end
end

Definitions::Validate.new(
  definitions_path,
  Definitions::Validation::Definition.new(
    Definitions::Validation::RegionNames.new(iso_names),
    Definitions::Validation::CustomMethod.new,
    Definitions::Validation::Month.new,
    Definitions::Validation::Test.new,
  ),
  Definitions::Validation::Index.new,
).call
