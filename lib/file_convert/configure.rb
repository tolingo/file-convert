module FileConvert
  module Configure
    require 'yaml'

    DEFAULT_CONFIG_PATH = 'config/file_convert.yml'

    def self.config_yaml_present?
      ::File.exist?(DEFAULT_CONFIG_PATH)
    end

    def self.config_from_yaml
      ::File.open(DEFAULT_CONFIG_PATH) do |file|
        YAML.load(file)['file_convert']
      end
    end

    def self.config
      @@config
    end

    ###
    # Loads config/file_convert.yml['file_convert'] into Config
    # Or defaults to empty Hash if config file is not present
    def self.init_config!
      @@config = config_yaml_present? ? config_from_yaml : {}
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
