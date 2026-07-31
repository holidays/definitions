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
      definition_files = (Dir.glob('*.yaml', base: path) - ['index.yaml']).sort

      begin
        @index_validator.call(index_file, definition_files)
      rescue Definitions::Errors::InvalidIndex => e
        puts "Failed on 'index.yaml', error: #{e}"
        exit 1
      end

      puts "Found #{definition_files.size} definition YAML files to check! Starting validation checks ..."

      # Every file is checked on every run so that a contributor sees all of the
      # problems at once rather than fixing one and rerunning to find the next.
      failures = {}

      definition_files.each do |item|
        errors = validate_file(path + item)
        failures[item] = errors unless errors.empty?
      end

      report(definition_files, failures)

      exit 1 unless failures.empty?
    end

    private

    def validate_file(target)
      @definition_validator.call(YAML.load(File.open(target)))
    rescue Psych::SyntaxError => e
      [
        "YAML parse error: #{e}",
        "This means your YAML is somehow invalid. Test your file on something like yamllint.com to find the issue.",
      ]
    rescue => e
      ["#{e.class}: #{e.message}"]
    end

    def report(definition_files, failures)
      puts "Validations complete!"
      puts
      puts "Summary"
      puts "---------"
      puts "Total files checked: #{definition_files.size}"
      puts "Passed: #{definition_files.size - failures.size}"
      puts "Failed: #{failures.size}"

      if failures.empty?
        puts
        puts "Success!"
        return
      end

      puts "Files containing validation errors: #{failures.keys.map { |file| "'#{file}'" }.join(', ')}"
      puts
      puts "Error details by definition file:"
      puts

      failures.each do |file, errors|
        puts "----"
        puts "File: #{file}"
        puts "Total errors found: #{errors.size}"
        puts "Details:"
        errors.each { |error| puts "  #{error}" }
        puts "----"
      end
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
