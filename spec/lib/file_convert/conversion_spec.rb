require 'spec_helper'

RSpec.describe FileConvert::Conversion do
  let(:file_path) { 'spec/fixtures/test.txt' }
  let(:source_mime_type) { 'text/plain' }
  let(:conversion_success) { true }
  let(:upload_error) { false }

  let(:client) do
    double(
      'FileConvert::Client',
      error?: upload_error,
      success?: conversion_success,
      data: { 'exportLinks' => {
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

    context 'when connection error occurs during fetch' do
      let(:conversion_success) { false }
      it 'raises' do
        expect { conversion }.to raise_error(
          FileConvert::Exception::DownloadConnectionError
        )
      end
    end

    context 'when error occured during file upload' do
      let(:upload_error) { true }
      it 'raises' do
        expect { conversion }.to raise_error(
          FileConvert::Exception::UploadConnectionError
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
