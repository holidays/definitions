require_relative 'error'

module Definitions
  module Validation
    class Month
      def call(months)
        raise Errors::NoMonths.new("Months is required, received: '#{months}'") if months.nil? || months.empty?

        months.each do |month, month_defs|
          raise Errors::InvalidMonth.new("All months must be an integer, received: #{months}") unless month.is_a?(Integer)
          raise Errors::InvalidMonth.new("All months must be between 0 and 12, received: #{months}") if month < 0 || month > 12

          month_defs.each do |month_def|
            raise Errors::InvalidMonth.new("All months must have a name, received: #{months}") if month_def['name'].nil? || month_def['name'].empty?

            raise Errors::InvalidRegions.new("A month must contain at least one region, received: #{months}") if month_def['regions'].nil? || month_def['regions'].empty?

            month_def['regions'].each do |region|
              raise Errors::InvalidRegions.new("A month must contain at least one region, received: #{months}") if region.nil? || region.empty?
            end

            if month_def.key?("year_ranges")
              month_def["year_ranges"].each do |yr|
                yr.each_pair do |k, v|
                  raise Errors::InvalidMonth.new("The :year_ranges value only accepts the following: :before, :after, :limited, :between, received: #{months}") unless [:before, :after, :limited, :between].include?(k.to_sym)

                  case k
                  when "after"
                    raise Errors::InvalidMonth.new("The year_ranges.after value must contain a single 'year' integer, ex. 2018, received: #{months}") unless v.is_a?(Integer)
                  when "limited"
                    raise Errors::InvalidMonth.new("The year_ranges.limited value must contain an array of 'year' integers, ex. [2018], received: #{months}") unless v.is_a?(Array)

                    v.each do |j|
                     raise Errors::InvalidMonth.new("The year_ranges.limited value must contain an array of 'year' integers, ex. [2018], received: #{months}") unless j.is_a?(Integer)
                    end
                  end
                end
              end
            end
          end
        end

        true
      end
    end
  end
end
