require 'spec_helper'
require 'validation/custom_method_validator'

describe Definitions::Validation::CustomMethod do
  let(:methods) {
    {
      'test' => {
        'arguments' => "date,year,month,day",
        'ruby' => "some source",
      }
    }
  }

  subject { described_class.new }

  context 'success' do
    it 'returns true' do
      expect(subject.call(methods)).to be true
    end
  end

  context 'failure' do
    context 'name' do
      it 'returns false if empty' do
        methods = {}
        methods[""]  = {}
        expect { subject.call(methods) }.to raise_error(Definitions::Errors::InvalidCustomMethod) { |e|
          expect(e.message).to eq("A custom method is missing a name, received: ''")
        }
      end
    end

    context 'arguments' do
      it 'returns false if nil' do
        methods['test']['arguments'] = nil
        expect { subject.call(methods) }.to raise_error(Definitions::Errors::InvalidCustomMethod) { |e|
          expect(e.message).to eq("Custom method 'test' has invalid arguments: ''. Valid arguments are: date, year, month, day, region")
        }
      end

      it 'returns false if empty' do
        methods['test']['arguments'] = ""
        expect { subject.call(methods) }.to raise_error(Definitions::Errors::InvalidCustomMethod) { |e|
          expect(e.message).to eq("Custom method 'test' has invalid arguments: ''. Valid arguments are: date, year, month, day, region")
        }
      end

      it 'accepts region as an argument' do
        methods['test']['arguments'] = "date, region"
        expect(subject.call(methods)).to be true
      end

      it 'names the method and the offending arguments if it contains an unknown variable' do
        methods['test']['arguments'] = "unknown"
        expect { subject.call(methods) }.to raise_error(Definitions::Errors::InvalidCustomMethod) { |e|
          expect(e.message).to eq("Custom method 'test' has invalid arguments: 'unknown'. Valid arguments are: date, year, month, day, region")
        }
      end
    end

    context 'source' do
      it 'returns false if nil' do
        methods['test']['ruby'] = nil
        expect { subject.call(methods) }.to raise_error(Definitions::Errors::InvalidCustomMethod) { |e|
          expect(e.message).to eq("Custom method 'test' is missing a 'ruby' source block")
        }
      end

      it 'returns false if empty' do
        methods['test']['ruby'] = ""
        expect { subject.call(methods) }.to raise_error(Definitions::Errors::InvalidCustomMethod) { |e|
          expect(e.message).to eq("Custom method 'test' is missing a 'ruby' source block")
        }
      end
    end
  end
end
