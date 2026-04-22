require 'spec_helper'
require 'validation/region_names_validator'

describe Definitions::Validation::RegionNames do
  let(:iso_names) { {} }
  subject { described_class.new(iso_names) }

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

    it 'returns true when ISO name matches the injected lookup' do
      iso_names = { "gb" => "United Kingdom" }
      months = { 1 => [{"name" => "Holiday", "regions" => ["gb"], "mday" => 1}] }
      region_names = { "gb" => "United Kingdom" }
      expect(described_class.new(iso_names).call(region_names, months)).to be true
    end

    it 'skips ISO validation for regions not in the lookup' do
      iso_names = {}
      months = { 1 => [{"name" => "Holiday", "regions" => ["nyse"], "mday" => 1}] }
      region_names = { "nyse" => "New York Stock Exchange" }
      expect(described_class.new(iso_names).call(region_names, months)).to be true
    end

    it 'skips ISO validation for regions in NON_ISO_REGIONS' do
      iso_names = { "vi" => "Virgin Islands (U.S.)" }
      months = { 1 => [{"name" => "Holiday", "regions" => ["vi"], "mday" => 1}] }
      region_names = { "vi" => "Viet Nam" }
      expect(described_class.new(iso_names).call(region_names, months)).to be true
    end

    it 'validates subdivision names correctly' do
      iso_names = { "de_by" => "Bayern" }
      months = { 1 => [{"name" => "Holiday", "regions" => ["de_by"], "mday" => 1}] }
      region_names = { "de_by" => "Bayern" }
      expect(described_class.new(iso_names).call(region_names, months)).to be true
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

    it 'raises error if a name does not match the ISO lookup' do
      iso_names = { "gb" => "United Kingdom" }
      months = { 1 => [{"name" => "Holiday", "regions" => ["gb"], "mday" => 1}] }
      region_names = { "gb" => "Great Britain" }
      expect { described_class.new(iso_names).call(region_names, months) }.to raise_error(Definitions::Errors::InvalidRegionNames) { |e|
        expect(e.message).to include("gb: expected 'United Kingdom' but got 'Great Britain'")
        expect(e.message).to include("See doc/SYNTAX.md for naming conventions.")
      }
    end
  end
end
