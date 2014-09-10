require 'spec_helper'

RSpec.describe FileConvert::Configure do

  before(:each) { FileConvert::Configure.class_variable_set(:@@config, nil) }
  let(:module_mock) do
    Module.new do
      extend FileConvert::Configure
    end
  end

  context 'with no config given' do
    describe '.config_present?' do
      subject { module_mock.config_present? }
      it { is_expected.to eq(false) }
    end

    describe '.config' do
      subject { module_mock.config }
      it { is_expected.to be_a(Hash) }
      it { is_expected.to be_empty }
    end
  end

  context 'with a given config' do
    describe '.config' do
      before do
        module_mock.configure do |config|
          config['foo'] = { bar: 'Elbschiffer' }
        end
      end

      subject { module_mock.config }
      it { is_expected.to be_a(Hash) }
      it { is_expected.to eq('foo' => { bar: 'Elbschiffer' }) }
    end
  end
end
