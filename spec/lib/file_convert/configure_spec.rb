require 'spec_helper'

describe FileConvert::Configure do

  before(:each) { FileConvert::Configure.class_variable_set(:@@config, nil) }
  let(:module_mock) do
    Module.new do
      extend FileConvert::Configure
      FileConvert::Configure.init_config!
    end
  end

  context 'from yaml' do
    before do
      stub_const(
        'FileConvert::Configure::DEFAULT_CONFIG_PATH',
        'config/file_convert.sample.yml'
      )
    end
    describe '.config' do
      subject { module_mock.config }
      it { is_expected.to be_a(Hash) }
      it { is_expected.to include('google_service_account') }
    end
  end

  context 'dynamic' do
    before do
      stub_const 'FileConvert::Configure::DEFAULT_CONFIG_PATH', '/tmp/foobar'
    end

    context 'default' do
      describe '.config' do
        subject { module_mock.config }
        it { is_expected.to be_a(Hash) }
        it { is_expected.to be_empty }
      end
    end

    context 'with no config given' do
      describe '.config_present?' do
        subject { module_mock.config_present? }
        it { is_expected.to eq(false) }
      end
    end

    context 'setting config at runtime' do
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
end
