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

      key = load_key gaccount['pkcs12_file_path'], 'notasecret'
      asserter = get_asserter gaccount['email'], gaccount['auth_url'], key

      super(APP_OPTIONS).tap do |client|
        client.authorization = asserter.authorize
        @drive = client.discovered_api('drive', 'v2')
      end
    end

    private

    def load_key(path, secret)
      Google::APIClient::PKCS12.load_key(path, secret)
    end

    def get_asserter(email, auth_url, key)
      Google::APIClient::JWTAsserter.new email, auth_url, key
    end
  end
end
