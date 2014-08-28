require 'spec_helper'

describe FileConvert do
  let(:client) { instance_double 'FileConvert::Client' }

  describe '.convert' do
    let(:file_path) { 'spec/fixtures/test.txt' }
    let(:source_mime_type) { 'text/plain' }
    let(:target_mime_type) { 'application/pdf' }

    let(:upload) { instance_double 'FileConvert::Upload', file: :uploaded_file }
    let(:conversion) { instance_double 'FileConvert::Conversion' }

    before do
      expect(FileConvert).to receive(:client).twice.and_return client
      expect(FileConvert::Upload).to receive(:new).and_return upload
      expect(FileConvert::Conversion).to receive(:new).with(
        client,
        :uploaded_file,
        target_mime_type
      ).and_return conversion
    end

    subject do
      FileConvert.convert(file_path, source_mime_type, target_mime_type)
    end
    it { is_expected.to equal conversion }
  end

  describe '.client' do
    context 'with no config given' do
      it 'should raise' do
        expect { FileConvert.client }.to raise_error(
          FileConvert::Exception::MissingConfig
        )
      end
    end

    context 'with config given' do
      let(:config) { { 'google_service_account' => :credentials } }

      before do
        FileConvert.configure { |c| c.replace(config) }
        expect(FileConvert::Client).to receive(:new).and_return client
      end

      subject { FileConvert.client }
      it { is_expected.to equal client }
    end
  end
end
