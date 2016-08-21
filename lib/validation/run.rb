## encoding: utf-8

require 'yaml'

require 'validation/custom_method_validator'

module Definitions
	class Validate
    def initialize(custom_method_validator = Definitions::Validator::CustomMethod.new)
      @custom_method_validator = custom_method_validator
    end

		def call(definitions_path)
			path = File.expand_path(File.dirname(__FILE__)) + definitions_path

      definition_count = 0

			Dir.foreach(path) do |item|
				next if item == '.' or item == '..'

				target = path+item
				next if File.extname(target) != '.yaml'

        definition_count += 1

				definition_file = YAML.load_file(target)
        #validate!(definition_file)

        #validator.valid?(definition_file['methods'])
			end

      puts "Success!"
      puts "Definition count: #{definition_count}"
		end

    private

		def validate!(definition)
			raise ArgumentError unless methods.all? do |name, pieces|
				@validator.valid?(
					{
						:name => name,
						:arguments => pieces["arguments"],
						:source => pieces["source"]
					}
				)
			end
		end
	end
end
