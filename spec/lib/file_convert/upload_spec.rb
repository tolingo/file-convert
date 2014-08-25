require File.join(File.dirname(__FILE__), '../../spec_helper.rb')

describe FileConvert::Upload do
  before(:all) { FileConvert::Configure::init_config! }

  let(:file_path) { 'spec/fixtures/test.txt' }
  let(:mime_type) { 'text/plain' }

  let(:client) { FileConvert::Client.new }
  let(:upload) { FileConvert::Upload.new(client, file_path, mime_type) }

  describe '#initialize' do
    subject { upload }
    it { should be_a(FileConvert::Upload) }
  end

  describe '#file' do
    subject { upload.file }
    it { should be_a(FileConvert::File) }
  end

end
