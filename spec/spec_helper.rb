require 'pry'
require File.expand_path('../../lib/file_convert', __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec do |mock_config|
    mock_config.verify_doubled_constant_names = true
    mock_config.syntax = [:expect]
  end
end

def configure_with_mock
  FileConvert.configure do |config|
    config['google_service_account'] = {
      'email' => '<strange-hash>@developer.gserviceaccount.com',
      'pkcs12_file_path' => 'config/file_convert_key.p12'
    }
  end
end
