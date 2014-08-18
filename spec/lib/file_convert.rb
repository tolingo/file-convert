require File.join(File.dirname(__FILE__), '../spec_helper.rb')

descibe FileConvert do

  describe '.convert' do
    let(:file_path) { 'spec/fixtures/test.txt' }
    let(:source_mime_type) { 'text/plain' }
    let(:target_mime_type) { 'application/pdf' }

    subject { FileConvert.convert(file_path, source_mime_type, target_mime_type) }
    it { should be_a(FileConvert::Conversion) }
  end

end
