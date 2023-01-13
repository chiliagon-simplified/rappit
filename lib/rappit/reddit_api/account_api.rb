# frozen_string_literal: true

require 'net/http'
require_relative '../api_endpoints'

module Rappit
  # Class for Account API calls
  class AccountAPI
    API_ME = '/api/v1/me'

    attr_reader :client_id, :client_secret

    def initialize(config)
      @client_id = config.client_id
      @client_secret = config.client_secret
    end

    def me(bearer_token)
      uri = URI(Rappit::O2AuthEndpoints::API_URL + API_ME)
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{bearer_token}"

      result = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
      JSON.parse(result.body)
    end
  end
end
