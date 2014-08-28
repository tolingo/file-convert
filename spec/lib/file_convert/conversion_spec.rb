require 'spec_helper'

describe FileConvert::Conversion do
  before(:all) { FileConvert::Configure.init_config! }

  let(:file_path) { 'spec/fixtures/test.txt' }
  let(:source_mime_type) { 'text/plain' }

  let(:client) do
    double(
      'FileConvert::Client', status: 200, data: { 'exportLinks' => {
        'text/html' => 'is_so_supported!'
      } }
    ).as_null_object
  end
  let(:upload) { FileConvert::Upload.new(client, file_path, source_mime_type) }
  let(:target_mime_type) { 'text/html' }

  let(:conversion) do
    FileConvert::Conversion.new(client, upload.file, target_mime_type)
  end

  describe '#initialize' do
    context 'existing mime-type' do
      let(:target_mime_type) { 'text/html' }
      subject { conversion }
      it { is_expected.to be_a(FileConvert::Conversion) }
    end

    context 'missing mime-type' do
      let(:target_mime_type) { 'text/foo' }
      it 'raises' do
        expect { conversion }.to raise_error(
          FileConvert::Exception::MissingConversionMimeType
        )
      end
    end
  end

  describe '#file' do
    context 'existing' do
      subject { conversion.file }
      it { is_expected.to eq client }
    end
  end

  describe '#body' do
    subject { conversion.body }
    it { is_expected.to include('<html>') }
    it { is_expected.to include('foobar') }
  end
end
