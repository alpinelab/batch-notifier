# frozen_string_literal: true
require "net/http"

module BatchNotifier
  module Util
    class HTTPClient
      attr_reader :uri, :payload

      def initialize uri, payload
        @uri      = uri
        @payload  = payload
      end

      class << self
        def post uri, payload
          HTTPClient.new(uri, payload).post
        end
      end

      def post
        http_obj.request(request_obj)
      end

    private
      def request_obj
        headers = {
          "Content-Type"    => "application/json",
          "X-Authorization" => BatchNotifier.configuration.rest_api_key
        }
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        req.body = payload.to_json
        req
      end

      def http_obj
        http = Net::HTTP.new uri.host, uri.port
        http.use_ssl = (uri.scheme == "https")
        http
      end
    end
  end
end
