require File.join(File.dirname(__FILE__), '../../spec_helper.rb')

describe FileConvert::Conversion do
  before(:all) { FileConvert::Configure::init_config! }

  let(:file_path) { 'spec/fixtures/test.txt' }
  let(:source_mime_type) { 'text/plain' }

  let(:client) { FileConvert::Client.new }
  let(:upload) { FileConvert::Upload.new(client, file_path, source_mime_type) }
  let(:target_mime_type) { 'text/html' }

  let(:conversion) { FileConvert::Conversion.new(client, upload.file, target_mime_type) }

  describe '#initialize' do
    context 'existing mime-type' do
      let(:target_mime_type) { 'text/html' }
      subject { conversion }
      it { should be_a(FileConvert::Conversion) }
    end

    context 'missing mime-type' do
      let(:target_mime_type) { 'text/foo' }
      it 'raises' do
        expect { conversion }.to raise_error(FileConvert::Exception::MissingConversionMimeType)
      end
    end
  end

  describe '#file' do
    context 'existing' do
      subject { conversion.file }
      it { should be_a(Google::APIClient::Result) }
    end
  end

  describe '#body' do
    subject { conversion.body }
    it { should include('<html>') }
    it { should include('foobar') }
  end

end
