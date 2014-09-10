module FileConvert
  module Configure
    def self.config
      @@config ||= {}
      @@config
    end

    def configure
      yield config
    end

    def config
      Configure.config
    end

    def config_present?
      provider = 'google_service_account'
      config.is_a?(Hash) && config.key?(provider)
    end
  end
end
