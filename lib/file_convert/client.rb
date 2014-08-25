module FileConvert
  require 'google/api_client'

  class Client < Google::APIClient
    APP_OPTIONS = {
      application_name: 'file-convert',
      application_version: FileConvert::Version::STRING
    }

    attr_reader :drive

    ###
    # Inherits from Google::APIClient
    # Basically wraps authentiation for simple configuration
    #
    # @return [FileConvert::Client] (inherits from Google::APIClient)
    def initialize
      gaccount = FileConvert.config['google_service_account']
      gaccount['auth_url'] ||= 'https://www.googleapis.com/auth/drive'

      key = Google::APIClient::PKCS12.load_key(gaccount['pkcs12_file_path'], 'notasecret')
      asserter = Google::APIClient::JWTAsserter.new(gaccount['email'], gaccount['auth_url'], key)

      super(APP_OPTIONS).tap do |client|
        client.authorization = asserter.authorize
        @drive = client.discovered_api('drive', 'v2')
      end
    end
  end
end
