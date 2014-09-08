require 'spec_helper'

RSpec.describe 'Google API' do
  before do
    unless ENV.key?('email') && ENV.key?('pkcspath')
      fail "Set ENV['email'] and ENV['pkcspath'] for these tests to work."
    end
    FileConvert.configure do |config|
      config['google_service_account'] = {
        'email' => ENV['email'],
        'pkcs12_file_path' => ENV['pkcspath']
      }
    end
  end

  # Remember that this `subject` triggers an API call
  subject do
    FileConvert.convert(file_path, source_mime_type, target_mime_type)
  end

  context 'can convert txt to pdf and' do
    let(:file_path) do
      File.join File.dirname(__FILE__), '..', 'fixtures', 'test.txt'
    end
    let(:converted_file_path) do
      File.join File.dirname(__FILE__), '..', 'fixtures', 'test.txt.pdf'
    end
    let(:source_mime_type) { 'text/plain' }
    let(:target_mime_type) { 'application/pdf' }

    it 'integrates perfectly' do
      expect(subject).to be_a FileConvert::Conversion

      expect(subject.body).to be_a String
      expect(subject.body).not_to be_empty

      expect(subject.file).to be_a Google::APIClient::Result

      tempfile = Tempfile.new 'You are such a file!'
      subject.save tempfile.path
      tempfile.close
      expect(
        FileUtils.compare_file converted_file_path, tempfile.path
      ).to be true
      tempfile.unlink
    end
  end

  context 'can convert doc to docx and' do
    let(:file_path) do
      File.join File.dirname(__FILE__), '..', 'fixtures', 'test.doc'
    end
    let(:converted_file_path) do
      File.join File.dirname(__FILE__), '..', 'fixtures', 'test.doc.docx'
    end
    let(:source_mime_type) { 'application/msword' }
    let(:target_mime_type) do
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    end

    it 'integrates perfectly' do
      expect(subject).to be_a FileConvert::Conversion

      expect(subject.body).to be_a String
      expect(subject.body).not_to be_empty

      expect(subject.file).to be_a Google::APIClient::Result
      # for some reason two converted docx files are not the same
      # when comparing with `FileUtils.compare_file`
    end
  end
end
