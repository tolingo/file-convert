require File.join(File.dirname(__FILE__), '../spec_helper.rb')

describe FileConvert do

  describe '.convert' do
    before { configure_with_mock }
    let(:file_path) { 'spec/fixtures/test.txt' }
    let(:source_mime_type) { 'text/plain' }
    let(:target_mime_type) { 'application/pdf' }

    subject { FileConvert.convert(file_path, source_mime_type, target_mime_type) }
    it { is_expected.to be_a(FileConvert::Conversion) }
  end

  describe '.client' do
    context 'with no config given' do
      before { FileConvert.configure { |config| config.replace({}) } }
      after  { FileConvert::Configure.init_config! }

      it 'should raise' do
        expect { FileConvert.send(:client) }.to raise_error(FileConvert::Exception::MissingConfig)
      end
    end
  end
end
