require_relative 'error'

module Definitions
  module Validation
    class Test
      def call(tests)
        raise Errors::InvalidTest if tests.empty?

        true
      end
    end
  end
end
