# frozen_string_literal: true
module BatchNotifier
  class Configuration
    class ConfigurationError < StandardError; end

    attr_accessor :api_url
    attr_accessor :api_version
    attr_accessor :api_keys
    attr_accessor :rest_api_key

    API_URL             = "https://api.batch.com"
    API_VERSION         = 1.1
    API_KEYS_SEPARATOR  = ","

    def initialize
      defaults.each do |setting, value|
        send("#{setting}=", value)
      end
    end

    def defaults
      {
        api_url:      ENV["BATCH_API_URL"]      || API_URL,
        api_version:  ENV["BATCH_API_VERSION"]  || API_VERSION,
        api_keys:     ENV["BATCH_API_KEYS"],
        rest_api_key: ENV["BATCH_REST_API_KEY"]
      }
    end

    def api_keys=(keys)
      @api_keys = keys.try(:split, API_KEYS_SEPARATOR) || []
    end

    def api_keys
      if @api_keys.empty?
        raise ConfigurationError.new("No api key provided")
      else
        @api_keys
      end
    end

    def rest_api_key
      if @rest_api_key.to_s.empty?
        raise ConfigurationError.new("No rest api key provided")
      else
        @rest_api_key
      end
    end
  end
end
