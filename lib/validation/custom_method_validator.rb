require_relative 'error'

module Definitions
  module Validation
    class CustomMethod
      VALID_ARGUMENTS = ["date", "year", "month", "day", "region"]

      def call(methods)
        methods.each do |name, method|
          unless valid_name?(name)
            raise Errors::InvalidCustomMethod.new("A custom method is missing a name, received: '#{name}'")
          end

          unless valid_arguments?(method['arguments'])
            raise Errors::InvalidCustomMethod.new(
              "Custom method '#{name}' has invalid arguments: '#{method['arguments']}'. " \
              "Valid arguments are: #{VALID_ARGUMENTS.join(', ')}"
            )
          end

          unless valid_source?(method['ruby'])
            raise Errors::InvalidCustomMethod.new("Custom method '#{name}' is missing a 'ruby' source block")
          end
        end

        true
      end

      private

      def valid_name?(name)
        !name.nil? && !name.empty?
      end

      def valid_arguments?(arguments)
        !arguments.nil? &&
          !arguments.empty? &&
          arguments.split(",").all? { |arg|
            arg == arg.chomp && VALID_ARGUMENTS.include?(arg.strip)
          }
      end

      def valid_source?(source)
        !source.nil? && !source.empty?
      end
    end
  end
end
