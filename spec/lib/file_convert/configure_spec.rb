require File.join(File.dirname(__FILE__), '../../spec_helper.rb')

describe FileConvert::Configure do

  before(:each) { FileConvert::Configure.class_variable_set(:@@config, nil) }
  let(:module_mock) {
    Module.new do
      extend FileConvert::Configure
      FileConvert::Configure::init_config!
    end
  }

  context 'from yaml' do
    before { stub_const('FileConvert::Configure::DEFAULT_CONFIG_PATH', 'config/file_convert.sample.yml') }
    describe '.config' do
      subject { module_mock.config }
      it { should be_a(Hash) }
      it { should include('google_service_account') }
    end
  end

  context 'dynamic' do
    before { stub_const('FileConvert::Configure::DEFAULT_CONFIG_PATH', '/tmp/foobar') }

    context 'default' do
      describe '.config' do
        subject { module_mock.config }
        it { should be_a(Hash) }
        it { should be_empty }
      end
    end

    context 'with no config given' do
      describe '.config_present?' do
        subject { module_mock.config_present? }
        it { should == false }
      end
    end

    context 'setting config at runtime' do
      describe '.config' do
        before {
          module_mock.configure do |config|
            config['foo'] = { bar: 'Elbschiffer' }
          end
        }

        subject { module_mock.config }
        it { should be_a(Hash) }
        it { should == { 'foo' => { bar: 'Elbschiffer' } } }
      end
    end
  end
end
