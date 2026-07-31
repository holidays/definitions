require 'spec_helper'
require 'validation/definition_validator'

describe Definitions::Validation::Definition do
  let(:region_names_validator) { double(:region_names_validator, :call => true) }
  let(:custom_method_validator) { double(:custom_method_validator, :call => true) }
  let(:months_validator) { double(:months_validator, :call => nil) }
  let(:test_validator) { double(:test_validator, :call => true) }

  let(:definition) { {
    "region_names" => { "test" => "Test Region" },
    "months" => { 1 => [{"name"=>"Test Holiday", "regions"=>["test"], "mday"=>1}] },
    "methods" =>{ "test" => {"arguments"=>"year", "source"=>"true"} },
    "tests" => "test"
  } }

  subject { described_class.new(region_names_validator, custom_method_validator, months_validator, test_validator) }

  context 'definition is valid' do
    it 'reports no errors' do
      expect(subject.call(definition)).to eq([])
    end
  end

  context 'invalid region_names' do
    it 'returns the error raised by the region_names validator' do
      expect(region_names_validator).to receive(:call).with(definition['region_names'], definition['months']).and_raise(Definitions::Errors::InvalidRegionNames.new("bad region names"))
      expect(subject.call(definition)).to eq(["bad region names"])
    end
  end

  context 'invalid months' do
    it 'returns the error raised by the months validator' do
      expect(months_validator).to receive(:call).with(definition['months']).and_raise(Definitions::Errors::InvalidMonth.new("bad months"))
      expect(subject.call(definition)).to eq(["bad months"])
    end

    it 'skips region_names validation because it depends on months' do
      expect(months_validator).to receive(:call).and_raise(Definitions::Errors::InvalidMonth.new("bad months"))
      expect(region_names_validator).to_not receive(:call)
      subject.call(definition)
    end
  end

  context 'invalid methods' do
    it 'returns the error raised by the custom method validator' do
      expect(custom_method_validator).to receive(:call).with(definition['methods']).and_raise(Definitions::Errors::InvalidCustomMethod.new("bad methods"))
      expect(subject.call(definition)).to eq(["bad methods"])
    end
  end

  context 'invalid tests' do
    it 'returns the error raised by the test validator' do
      expect(test_validator).to receive(:call).with(definition['tests']).and_raise(Definitions::Errors::InvalidTest.new("bad tests"))
      expect(subject.call(definition)).to eq(["bad tests"])
    end
  end

  context 'multiple invalid sections' do
    it 'returns every error rather than stopping at the first' do
      expect(months_validator).to receive(:call).and_raise(Definitions::Errors::InvalidMonth.new("bad months"))
      expect(custom_method_validator).to receive(:call).and_raise(Definitions::Errors::InvalidCustomMethod.new("bad methods"))
      expect(test_validator).to receive(:call).and_raise(Definitions::Errors::InvalidTest.new("bad tests"))

      expect(subject.call(definition)).to eq(["bad months", "bad methods", "bad tests"])
    end
  end

  context 'no methods' do
    it 'reports no errors' do
      definition["methods"] = nil
      expect(subject.call(definition)).to eq([])
    end
  end

  context 'no tests' do
    it 'reports no errors' do
      definition["tests"] = nil
      expect(subject.call(definition)).to eq([])
    end
  end

  context 'unexpected errors' do
    it 'does not swallow errors that are not validation errors' do
      expect(months_validator).to receive(:call).and_raise(NoMethodError.new("something is actually broken"))
      expect { subject.call(definition) }.to raise_error(NoMethodError)
    end
  end
end
