require 'spec_helper'
require 'validation/custom_method_validator'

describe Definitions::Validator::CustomMethod do
  let(:definition) {
    {
      :name => 'test',
      :arguments => "date,year,month,day",
      :source => "some source",
    }
  }

  subject { described_class.new }

  context 'success' do
    it 'returns true' do
      expect(subject.valid?(definition)).to be true
    end
  end

  context 'failure' do
    context 'name' do
      it 'returns false if nil' do
        definition[:name] = nil
        expect(subject.valid?(definition)).to be false
      end

      it 'returns false if empty' do
        definition[:name] = ""
        expect(subject.valid?(definition)).to be false
      end
    end

    context 'arguments' do
      it 'returns false if nil' do
        definition[:arguments] = nil
        expect(subject.valid?(definition)).to be false
      end

      it 'returns false if empty' do
        definition[:arguments] = ""
        expect(subject.valid?(definition)).to be false
      end

      it 'returns false if contains unknown variable' do
        definition[:arguments] = "unknown"
        expect(subject.valid?(definition)).to be false
      end
    end

    context 'source' do
      it 'returns false if nil' do
        definition[:source] = nil
        expect(subject.valid?(definition)).to be false
      end

      it 'returns false if empty' do
        definition[:source] = ""
        expect(subject.valid?(definition)).to be false
      end
    end
  end
end
