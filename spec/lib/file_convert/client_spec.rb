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
  let(:authorization) { double('Signet::OAuth2::Client').as_null_object }

  before do
    expect(FileConvert).to receive_messages config: config
    expect(Signet::OAuth2::Client).to receive_messages new: authorization
    expect(Google::APIClient::PKCS12).to receive(:load_key).with(
      :pkcs12_file_path, 'notasecret'
    )
    @client = FileConvert::Client.new
  end

  describe '#initialize' do
    subject { @client }
    it { is_expected.to be_a(Google::APIClient) }
    it 'should retry failed requests once' do
      expect(@client.retries).to be 1
    end
  end

  describe '#drive' do
    subject { @client.drive.name }
    it { is_expected.to eq('drive') }
  end
end
