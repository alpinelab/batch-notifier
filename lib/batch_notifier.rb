# frozen_string_literal: true
require "uri"
require "json"

require_relative "batch_notifier/util/http_client"
require_relative "batch_notifier/configuration"
require_relative "batch_notifier/transactional"
require_relative "batch_notifier/response"

module BatchNotifier
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end

    def transactional group_id:, recipients:, title:, body:, deeplink:
      transactional = BatchNotifier::Transactional.new(
        group_id,
        recipients,
        title,
        body,
        deeplink
      )
      post(BatchNotifier::Transactional::ENDPOINT, transactional.payload)
    end

  private
    def post endpoint, payload={}
      self.configure unless self.configuration
      responses = []
      self.configuration.api_keys.each do |api_key|
        uri = route(endpoint, api_key)
        res = Util::HTTPClient.post(uri, payload)
        responses << BatchNotifier::Response.new(endpoint, api_key, res)
      end
      responses
    end

    def route(endpoint, api_key)
      URI.parse [
        configuration.api_url,
        configuration.api_version,
        api_key,
        endpoint
      ].join("/")
    end
  end
end
