require 'pry'
require File.join(File.dirname(__FILE__), '/../lib/file_convert')

def configure_with_mock
  FileConvert.configure do |config|
    config['google_service_account'] = {
      'email' => '<strange-hash>@developer.gserviceaccount.com',
      'pkcs12_file_path' => 'config/file_convert_key.p12'
    }
  end
end
