require File.join(File.dirname(__FILE__), '../../spec_helper.rb')
require File.join(File.dirname(__FILE__), '../../spec_helper.rb')

describe FileConvert::Conversion do
  before(:all) { FileConvert::Configure::init_config! }

  let(:original_file) { double('file', data: 'tanzbar') }
  subject { @file }

  before :each do
    @file = FileConvert::File.new(original_file)
  end

  describe '#initialize' do
    it { is_expected.to be_a(FileConvert::File) }
  end

  describe '#data' do
    subject { @file.data }
    it { is_expected.to eq('tanzbar') }
  end

  describe '#conversions' do
    subject { @file.conversions }

    context 'after initialization' do
      it { is_expected.to eq({}) }
    end

    context 'after adding a conversion' do
      before { @file.add_conversion('foo', 'bar') }
      it { is_expected.to eq({ 'foo' => 'bar' }) }
    end
  end

end
