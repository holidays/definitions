require 'spec_helper'
require 'validation/index_validator'

describe Definitions::Validation::Index do
  subject { described_class.new }

  let(:index) { { 'defs' => { 'US' => ['us.yaml'], 'CA' => ['ca.yaml'] } } }
  let(:definition_files) { ['us.yaml', 'ca.yaml'] }

  context 'valid' do
    it 'returns true when the index and the files on disk agree' do
      expect(subject.call(index, definition_files)).to be true
    end

    it 'allows a region to list additional files beyond its own' do
      index = { 'defs' => { 'US' => ['us.yaml', 'northamericainformal.yaml'] } }
      expect(subject.call(index, ['us.yaml', 'northamericainformal.yaml'])).to be true
    end

    it 'allows the same file to be listed under multiple regions' do
      index = { 'defs' => { 'US' => ['us.yaml'], 'NorthAmerica' => ['us.yaml'] } }
      expect(subject.call(index, ['us.yaml'])).to be true
    end

    it 'allows aggregate regions to have no definition file of their own' do
      index = {
        'defs' => {
          'Europe' => ['fr.yaml'],
          'NorthAmerica' => ['us.yaml'],
          'Scandinavia' => ['no.yaml'],
          'SouthAmerica' => ['br.yaml'],
          'FR' => ['fr.yaml'],
          'US' => ['us.yaml'],
          'NO' => ['no.yaml'],
          'BR' => ['br.yaml'],
        }
      }
      expect(subject.call(index, ['fr.yaml', 'us.yaml', 'no.yaml', 'br.yaml'])).to be true
    end

    it 'matches mixed case region keys against their lowercase file names' do
      index = { 'defs' => { 'FederalReserve' => ['federalreserve.yaml'] } }
      expect(subject.call(index, ['federalreserve.yaml'])).to be true
    end

    it 'allows underscores in region keys and file names' do
      index = { 'defs' => { 'BE_FR' => ['be_fr.yaml'] } }
      expect(subject.call(index, ['be_fr.yaml'])).to be true
    end
  end

  context 'invalid structure' do
    it 'raises error if the index is not a hash' do
      expect { subject.call('bad', definition_files) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index must be a hash, received: 'bad'")
      }
    end

    it 'raises error if the index has no defs entry' do
      expect { subject.call({}, definition_files) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index is missing a 'defs' entry")
      }
    end

    it 'raises error if defs is not a hash' do
      expect { subject.call({ 'defs' => ['us.yaml'] }, definition_files) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index 'defs' must be a hash, received: '[\"us.yaml\"]'")
      }
    end

    it 'raises error if defs is empty' do
      expect { subject.call({ 'defs' => {} }, definition_files) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index 'defs' must not be empty")
      }
    end

    it 'raises error if a region entry is not an array' do
      index = { 'defs' => { 'US' => 'us.yaml' } }
      expect { subject.call(index, ['us.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index entry for 'US' must be a non-empty array, received: 'us.yaml'")
      }
    end

    it 'raises error if a region entry is an empty array' do
      index = { 'defs' => { 'US' => [] } }
      expect { subject.call(index, ['us.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index entry for 'US' must be a non-empty array, received: '[]'")
      }
    end
  end

  context 'invalid file names' do
    it 'raises error if an indexed file is uppercase' do
      index = { 'defs' => { 'US' => ['US.yaml'] } }
      expect { subject.call(index, ['US.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("index lists files with invalid names: US.yaml")
        expect(e.message).to include("must be lowercase and end in '.yaml'")
      }
    end

    it 'raises error if an indexed file uses a dash instead of an underscore' do
      index = { 'defs' => { 'BE_FR' => ['be-fr.yaml'] } }
      expect { subject.call(index, ['be-fr.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("index lists files with invalid names: be-fr.yaml")
      }
    end

    it 'raises error if an indexed file has the wrong extension' do
      index = { 'defs' => { 'US' => ['us.yml'] } }
      expect { subject.call(index, ['us.yml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("index lists files with invalid names: us.yml")
      }
    end
  end

  context 'files missing from the index' do
    it 'raises error if a definition file on disk is not listed' do
      expect { subject.call(index, definition_files + ['hk.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("definition files are not listed in index.yaml: hk.yaml")
        expect(e.message).to include("Please add them to the appropriate region entry in index.yaml.")
      }
    end

    it 'reports every unlisted file, sorted' do
      expect { subject.call(index, definition_files + ['zz.yaml', 'hk.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("definition files are not listed in index.yaml: hk.yaml, zz.yaml")
      }
    end
  end

  context 'indexed files that do not exist' do
    it 'raises error if the index lists a file that is not on disk' do
      index = { 'defs' => { 'US' => ['us.yaml'], 'HK' => ['hk.yaml'] } }
      expect { subject.call(index, ['us.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index.yaml lists files that do not exist: hk.yaml")
      }
    end

    it 'reports every missing file, sorted' do
      index = { 'defs' => { 'US' => ['us.yaml', 'zz.yaml'], 'HK' => ['hk.yaml'] } }
      expect { subject.call(index, ['us.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to eq("index.yaml lists files that do not exist: hk.yaml, zz.yaml")
      }
    end
  end

  context 'region file name mismatches' do
    it 'raises error if a region does not list its own definition file' do
      index = { 'defs' => { 'US' => ['ca.yaml'] } }
      expect { subject.call(index, ['ca.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("index entries do not list their own definition file: US (expected 'us.yaml')")
        expect(e.message).to include("unless it is an aggregate of other regions")
      }
    end

    it 'reports every mismatched region, sorted' do
      index = { 'defs' => { 'US' => ['ca.yaml'], 'GB' => ['ca.yaml'] } }
      expect { subject.call(index, ['ca.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("index entries do not list their own definition file: GB (expected 'gb.yaml'), US (expected 'us.yaml')")
      }
    end

    it 'raises error for a region that is not a known aggregate' do
      index = { 'defs' => { 'Asia' => ['jp.yaml'], 'JP' => ['jp.yaml'] } }
      expect { subject.call(index, ['jp.yaml']) }.to raise_error(Definitions::Errors::InvalidIndex) { |e|
        expect(e.message).to include("Asia (expected 'asia.yaml')")
      }
    end
  end
end
