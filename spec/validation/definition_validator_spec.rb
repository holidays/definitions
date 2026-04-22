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
    it 'reports success' do
      expect(subject.call(definition)).to be true
    end
  end

  context 'invalid region_names' do
    it 'raises error if region_names validator raises error' do
      expect(region_names_validator).to receive(:call).with(definition['region_names'], definition['months']).and_raise(StandardError)
      expect { subject.call(definition) }.to raise_error(StandardError)
    end
  end

  context 'invalid months' do
    it 'raises error if months validator raises error' do
      expect(months_validator).to receive(:call).with(definition['months']).and_raise(StandardError)
      expect { subject.call(definition) }.to raise_error(StandardError)
    end
  end

  context 'no methods' do
    it 'returns success' do
      definition["methods"] = nil
      expect(subject.call(definition)).to be true
    end
  end

  context 'no tests' do
    it 'raises error' do
      expect(test_validator).to receive(:call).with(definition['tests']).and_raise(StandardError)
      expect { subject.call(definition) }.to raise_error(StandardError)
    end
  end
end
