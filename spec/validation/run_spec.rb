require 'spec_helper'
require 'validation/run'

describe Definitions::Validate do
  let(:path) { "/../../spec/data/" }
  let(:custom_method_validator) { double(:custom_method_validator) }

  subject { described_class.new(custom_method_validator).call(path) }

  context 'definition is valid' do
    it 'reports success' do
      expect(STDOUT).to receive(:puts).with('Success!')
      expect(STDOUT).to receive(:puts).with('Definition count: 1')

      subject
    end
  end
end
