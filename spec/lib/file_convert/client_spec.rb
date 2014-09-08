require 'spec_helper'

RSpec.describe FileConvert::Client do
  let(:config) do
    {
      'google_service_account' => {
        'pkcs12_file_path' => :pkcs12_file_path,
        'email' => :email
      }
    }
  end
  let(:asserter) { double('Google::APIClient::JWTAsserter').as_null_object }

  before do
    expect(FileConvert).to receive_messages config: config
    expect(Google::APIClient::JWTAsserter).to receive_messages new: asserter
    expect(Google::APIClient::PKCS12).to receive(:load_key).with(
      :pkcs12_file_path, 'notasecret'
    )
    @client = FileConvert::Client.new
  end

  describe '#initialize' do
    subject { @client }
    it { is_expected.to be_a(Google::APIClient) }
  end

  describe '#drive' do
    subject { @client.drive.name }
    it { is_expected.to eq('drive') }
  end

end
