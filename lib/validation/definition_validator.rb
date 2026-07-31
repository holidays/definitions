require_relative 'error'

module Definitions
  module Validation
    class Definition
      def initialize(region_names_validator, custom_method_validator, months_validator, test_validator)
        @region_names_validator = region_names_validator
        @custom_method_validator = custom_method_validator
        @months_validator = months_validator
        @test_validator = test_validator
      end

      # Returns every error found in the definition rather than stopping at the first
      # one, so that a contributor can see problems in 'months', 'methods' and 'tests'
      # in a single run. Errors are collected per section: the first problem within a
      # given section still ends that section's validation.
      def call(definition)
        errors = []

        month_errors = collect { @months_validator.call(definition['months']) }
        errors.concat(month_errors)

        # region_names coverage is derived from the regions listed in 'months', so it
        # can only be checked once we know 'months' itself is well formed.
        errors.concat(collect { @region_names_validator.call(definition['region_names'], definition['months']) }) if month_errors.empty?

        errors.concat(collect { @custom_method_validator.call(definition['methods']) }) unless definition['methods'].nil?
        errors.concat(collect { @test_validator.call(definition['tests']) }) unless definition['tests'].nil?

        errors
      end

      private

      def collect
        yield
        []
      rescue Errors::Error => e
        [e.message]
      end
    end
  end
end
