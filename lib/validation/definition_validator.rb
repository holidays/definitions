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

      def call(definition)
        @region_names_validator.call(definition['region_names'], definition['months'])
        @months_validator.call(definition['months'])
        @custom_method_validator.call(definition['methods']) unless definition['methods'].nil?
        @test_validator.call(definition['tests']) unless definition['tests'].nil?

        true
      end
    end
  end
end
