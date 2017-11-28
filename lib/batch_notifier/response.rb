# frozen_string_literal: true
module BatchNotifier
  class Response
    attr_accessor :endpoint, :api_key, :http_response

    def initialize(endpoint, api_key, http_response)
      @endpoint       = endpoint
      @api_key        = api_key
      @http_response  = http_response
    end

    def status
      http_response.code
    end

    def body
      @body ||= JSON.parse(http_response.body)
    end

    def token
      body["token"]
    end

    def success?
      http_response.is_a?(Net::HTTPSuccess)
    end
  end
end
