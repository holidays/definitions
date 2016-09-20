require 'spec_helper'
require 'validation/month_validator'

describe Definitions::Validation::Month do
  subject { described_class.new }

  context 'months are valid' do
    it 'reports success' do
      months =  { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
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
        expect(e.message).to eq("All months must be an integer, received: #{months}")
      }
    end

    it 'returns error if months not 0 through 12' do
      months = { -1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("All months must be between 0 and 12, received: #{months}")
      }

      months = { 13 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("All months must be between 0 and 12, received: #{months}")
      }
    end

    it 'returns error if month has no name' do
      months = { 1 => [{""=>"Test Holiday", "regions"=>["test"], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidMonth) { |e|
        expect(e.message).to eq("All months must have a name, received: #{months}")
      }
    end

    it 'returns error if month has no regions' do
      months = { 1 => [{"name"=>"Test Holiday", "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
        expect(e.message).to eq("A month must contain at least one region, received: #{months}")
      }
    end

    it 'returns error if month has empty regions' do
      months = { 1 => [{"name"=>"Test Holiday", "regions" => [], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
        expect(e.message).to eq("A month must contain at least one region, received: #{months}")
      }
    end

    it 'returns error if month has empty regions' do
      months = { 1 => [{"name"=>"Test Holiday", "regions"=>[""], "mday"=>1}] }
      expect { subject.call(months) }.to raise_error(Definitions::Errors::InvalidRegions) { |e|
        expect(e.message).to eq("A month must contain at least one region, received: #{months}")
      }
    end
  end
end
