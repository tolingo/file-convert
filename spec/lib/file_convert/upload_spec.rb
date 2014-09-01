require 'spec_helper'

describe FileConvert::Upload do
  let(:file_path) { 'spec/fixtures/test.txt' }
  let(:mime_type) { 'text/plain' }

  let(:client) { double('FileConvert::Client').as_null_object }
  let(:upload) { FileConvert::Upload.new(client, file_path, mime_type) }

  before do
    expect(Google::APIClient::UploadIO).to receive(:new).with(
      file_path, mime_type
    )
  end

  describe '#initialize' do
    subject { upload }
    it { is_expected.to be_a(FileConvert::Upload) }
  end

  describe '#file' do
    subject { upload.file }
    it { is_expected.to be_a(FileConvert::File) }
  end
end
