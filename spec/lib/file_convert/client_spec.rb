require File.join(File.dirname(__FILE__), '../../spec_helper.rb')

describe FileConvert::Client do
  before(:all) { configure_with_mock }

  before :each do
    @client = FileConvert::Client.new
  end

  describe '#initialize' do
    subject { @client }
    it { should be_a(Google::APIClient) }
  end

  describe '#drive' do
    subject { @client.drive.name }
    it { should == 'drive' }
  end

end
