require 'spec_helper'
require 'validation/month_validator'

describe Definitions::Validation::Month do
  subject { described_class.new }

  context 'months are valid' do
    it 'reports success' do
      months =  { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect(subject.call(months)).to be true
    end

    it 'reports success with excluded_regions that are subregions of its regions' do
      months =  { 6 => [{"name"=>"Juneteenth", "regions"=>["us", "ca"], "excluded_regions"=>["us_hi", "ca_qc_x"], "mday"=>19}] }
      expect(subject.call(months)).to be true
    end
  end

  context 'invalid months' do
    it 'returns error if missing' do
      expect { subject.call(nil) }.to raise_error(Definitions::Errors::NoMonths)
    end

    it 'returns error if empty' do
      expect { subject.call({}) }.to raise_error(Definitions::Errors::NoMonths)
      expect { subject.call([]) }.to raise_error(Definitions::Errors::NoMonths)
    end

    it 'returns error if month not an integer' do
      months = { 'january' => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("Month key must be an integer, received: 'january'")
      }
    end

    it 'returns error if months not 0 through 12' do
      months = { -1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("Month key must be between 0 and 12, received: '-1'")
      }

      months = { 13 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("Month key must be between 0 and 12, received: '13'")
      }
    end

    it 'returns error if month has no name' do
      months = { 1 => [{""=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("A holiday in month 1 is missing a 'name', received: #{months[1].first}")
      }
    end

    it 'returns error if month has no regions' do
      months = { 1 => [{"name"=>"Test Holiday", "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
        expect(e.message).to eq("Holiday 'Test Holiday' in month 1 must contain at least one region, received: nil")
      }
    end

    it 'returns error if month has empty regions' do
      months = { 1 => [{"name"=>"Test Holiday", "regions" => [], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
        expect(e.message).to eq("Holiday 'Test Holiday' in month 1 must contain at least one region, received: []")
      }
    end

    it 'returns error if month has empty regions' do
      months = { 1 => [{"name"=>"Test Holiday", "regions"=>[""], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
        expect(e.message).to eq("Holiday 'Test Holiday' in month 1 contains an empty region, received: [\"\"]")
      }
    end

    context 'year_ranges' do
      it 'returns error if year_ranges contains unknown subkey' do
        months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"blah" => [2018]} }] }
        expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
          expect(e.message).to eq("Holiday 'Test Holiday' in month 1 has an invalid year_ranges selector 'blah'. Valid selectors are: until, from, limited, between")
        }
      end

      it 'returns error if :until value is not a single integer' do
        months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"until" => [2018]} }] }
        expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
          expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.until must contain a single 'year' integer, ex. 2018, received: [2018]")
        }
      end

      it 'returns error if :from value is not a single integer' do
        months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"from" => [2018]} }] }
        expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
          expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.from must contain a single 'year' integer, ex. 2018, received: [2018]")
        }
      end

      it 'returns error if :limited value is not an array' do
        months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"limited" => 2018} }] }
        expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
          expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.limited must contain an array of 'year' integers, ex. [2018], received: 2018")
        }
      end

      it 'returns error if :limited value is not an array of integers' do
        months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"limited" => ["blah"]} }] }
        expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
          expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.limited must contain only 'year' integers, ex. [2018], received: 'blah'")
        }
      end

      context 'between' do
        it 'returns error if not a hash' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => "2008..2012" } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between must contain both a 'start' and 'end' key, received: \"2008..2012\"")
          }
        end

        it 'returns error if start is missing' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => {"end" => 2018} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between must contain both a 'start' and 'end' key, received: #{{"end" => 2018}.inspect}")
          }
        end

        it 'returns error if end is missing' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => {"start" => 2016} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between must contain both a 'start' and 'end' key, received: #{{"start" => 2016}.inspect}")
          }
        end

        it 'returns an error if start value is not an integer' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => {"start" => "2016", "end" => 2018} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between.start must contain a single 'year' integer, ex. 2018, received: \"2016\"")
          }
        end

        it 'returns an error if end value is not an integer' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => {"start" => 2016, "end" => "2018"} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between.end must contain a single 'year' integer, ex. 2018, received: \"2018\"")
          }
        end

        it 'returns an error if end value is before start' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => {"start" => 2016, "end" => 2015} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between.end cannot be before the start value, received start: 2016, end: 2015")
          }
        end

        it 'returns an error if the start and end values are the same' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"between" => {"start" => 2016, "end" => 2016} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to eq("Holiday 'Test Holiday' in month 1 year_ranges.between start and end values cannot be the same, received: 2016")
          }
        end
      end

      context 'with multiple selectors' do
        it 'returns an error if provided an array' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => [{"from" => 2019}, {"between" => {"start" => 2014, "end" => 2016} }] }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to include("Holiday 'Test Holiday' in month 1 year_ranges only supports a single selector at this time, received: [")
          }
        end

        it 'returns an error if there is more than 1 sub key' do
          months = { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1, "year_ranges" => {"from" => 2019, "between" => {"start" => 2014, "end" => 2016} } }] }
          expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
            expect(e.message).to include("Holiday 'Test Holiday' in month 1 year_ranges only supports a single selector at this time, received: {")
          }
        end
      end
    end

    context 'excluded_regions' do
      def months_with(excluded, regions = ["us"])
        { 6 => [{"name"=>"Juneteenth", "regions"=>regions, "excluded_regions"=>excluded, "mday"=>19}] }
      end

      it 'returns error if excluded_regions is not an array' do
        expect { subject.call(months_with("us_hi")) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions must be a non-empty array of regions, received: \"us_hi\"")
        }
      end

      it 'returns error if excluded_regions is nil' do
        expect { subject.call(months_with(nil)) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions must be a non-empty array of regions, received: nil")
        }
      end

      it 'returns error if excluded_regions is empty' do
        expect { subject.call(months_with([])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions must be a non-empty array of regions, received: []")
        }
      end

      it 'returns error if excluded_regions contains an empty region' do
        expect { subject.call(months_with(["us_hi", ""])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions contains an empty or non-string region, received: [\"us_hi\", \"\"]")
        }
      end

      it 'returns error if excluded_regions contains a non-string region' do
        expect { subject.call(months_with([false])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions contains an empty or non-string region, received: [false]")
        }
      end

      it 'returns error if an excluded region also appears in regions' do
        expect { subject.call(months_with(["us_hi"], ["us", "us_hi"])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions entry 'us_hi' also appears in regions, received: [\"us\", \"us_hi\"]")
        }
      end

      it 'returns error if an excluded region is the same as its region' do
        expect { subject.call(months_with(["us"])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions entry 'us' also appears in regions, received: [\"us\"]")
        }
      end

      it 'returns error if an excluded region is not a subregion of any region' do
        expect { subject.call(months_with(["ca_on"])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions entry 'ca_on' must be a subregion of one of its regions, received: [\"us\"]")
        }
      end

      it 'returns error if an excluded region only shares a prefix with a region' do
        expect { subject.call(months_with(["usa"])) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
          expect(e.message).to eq("Holiday 'Juneteenth' in month 6 excluded_regions entry 'usa' must be a subregion of one of its regions, received: [\"us\"]")
        }
      end
    end
  end
end
