require 'spec_helper'
require 'validation/test_validator'

describe Definitions::Validation::Test do
  subject { described_class.new }

  context 'tests exist' do
    it 'reports success' do
      tests = "some tests"
      expect(subject.call(tests)).to be true
    end
  end

  context 'tests are empty' do
    it 'raises error' do
      tests = ""
      expect { subject.call(tests) }.to raise_error(Definitions::Errors::InvalidTest)
    end
  end
end
