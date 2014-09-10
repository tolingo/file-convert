module FileConvert
  require 'google/api_client'
  require 'signet/oauth_2/client'

  class Client < Google::APIClient
    APP_OPTIONS = {
      application_name: 'file-convert',
      application_version: FileConvert::Version::STRING,
      # Retry request **once** in case authorization failed
      retries: 1
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
      options = APP_OPTIONS.merge(authorization: get_authorization(
        gaccount['email'], gaccount['auth_url'], key
      ))

      super(options).tap do |client|
        client.authorization.fetch_access_token!
        @drive = client.discovered_api 'drive', 'v2'
      end
    end

    private

    def load_key(path, secret)
      Google::APIClient::PKCS12.load_key(path, secret)
    end

    def get_authorization(email, auth_url, key)
      Signet::OAuth2::Client.new(
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience: 'https://accounts.google.com/o/oauth2/token',
        scope: auth_url,
        issuer: email,
        signing_key: key
      )
    end
  end
end
