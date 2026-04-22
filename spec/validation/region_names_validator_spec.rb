require 'spec_helper'
require 'validation/region_names_validator'

describe Definitions::Validation::RegionNames do
  subject { described_class.new }

  let(:months) { { 1 => [{"name" => "Test Holiday", "regions" => ["us"], "mday" => 1}] } }
  let(:region_names) { { "us" => "United States" } }

  context 'valid' do
    it 'returns true when region_names matches regions in months' do
      expect(subject.call(region_names, months)).to be true
    end

    it 'returns true with multiple regions across multiple months' do
      months = {
        1 => [{"name" => "Holiday A", "regions" => ["us", "ca"], "mday" => 1}],
        7 => [{"name" => "Holiday B", "regions" => ["ca"], "mday" => 1}],
      }
      region_names = { "us" => "United States", "ca" => "Canada" }
      expect(subject.call(region_names, months)).to be true
    end
  end

  context 'invalid' do
    it 'raises error if region_names is nil' do
      expect { subject.call(nil, months) }.to raise_error(Definitions::Errors::InvalidRegionNames) { |e|
        expect(e.message).to eq("region_names is required")
      }
    end

    it 'raises error if region_names is not a hash' do
      expect { subject.call("bad", months) }.to raise_error(Definitions::Errors::InvalidRegionNames) { |e|
        expect(e.message).to eq("region_names must be a hash, received: 'bad'")
      }
    end

    it 'raises error if region_names is empty' do
      expect { subject.call({}, months) }.to raise_error(Definitions::Errors::InvalidRegionNames) { |e|
        expect(e.message).to eq("region_names must not be empty")
      }
    end

    it 'raises error if a region in months is missing from region_names' do
      months = { 1 => [{"name" => "Holiday", "regions" => ["us", "ca"], "mday" => 1}] }
      expect { subject.call(region_names, months) }.to raise_error(Definitions::Errors::InvalidRegionNames) { |e|
        expect(e.message).to eq("region_names is missing entries for regions: ca")
      }
    end

    it 'raises error if region_names contains a region not in months' do
      region_names = { "us" => "United States", "ca" => "Canada" }
      expect { subject.call(region_names, months) }.to raise_error(Definitions::Errors::InvalidRegionNames) { |e|
        expect(e.message).to eq("region_names has entries for regions not found in months: ca")
      }
    end
  end
end
