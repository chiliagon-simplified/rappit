# frozen_string_literal: true

# require 'uri'
require 'net/http'
require 'byebug'
require_relative 'auth_scopes'
require_relative '../api_endpoints'

module Rappit
  # Class for O2 Auth API
  class O2AuthApi
    attr_reader :client_id, :client_secret, :redirect_uri, :open_browser_from_cmd_line

    def initialize(config)
      @client_id = config.client_id
      @client_secret = config.client_secret
      @redirect_uri = config.redirect_uri
      @open_browser_from_cmd_line = config.open_browser_from_cmd_line
      @response_type = config.response_type
    end

    def generate_auth_scope(scope, duration = Rappit::AuthDurations::PERMANENT)
      url = if Rappit::AuthScopes::SCOPES.include? scope
              generate_scope(scope, duration)
            else
              # default to identity, maybe raise error here instead
              generate_scope(Rappit::AuthScopes::IDENTITY, duration)
            end

      command_line_open_browser(url) if @open_browser_from_cmd_line
      url unless @open_browser_from_cmd_line
    end

    def generate_scope(scope, duration)
      "#{O2AuthEndpoints::AUTHORIZE_REDDIT_URL}?client_id=#{@client_id}" \
        "&response_type=#{@response_type}" \
        "&state=#{generate_random_string}" \
        "&redirect_uri=#{@redirect_uri}" \
        "&duration=#{duration}" \
        "&scope=#{scope}"
    end

    def generate_access_token(code)
      uri = URI(Rappit::O2AuthEndpoints::ACCESS_TOKEN_URL)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth @client_id, @client_secret
      req['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = generate_token_params(code)

      result = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
      JSON.parse(result.body)
    end

    def command_line_open_browser(url)
      cmd = case RbConfig::CONFIG['host_os']
            when /mswin|mingw|cygwin/ then 'start'
            when /darwin/ then 'open'
            when /linux|bsd/ then 'xdg-open'
            else raise 'No OS detected'
            end

      system cmd, url
    end

    private

    def generate_random_string
      (0...8).map { rand(65..70).chr }.join
    end

    def generate_token_params(code)
      URI.encode_www_form({
                            'code' => code,
                            'redirect_uri' => @redirect_uri,
                            'grant_type' => 'authorization_code'
                          })
    end
  end
end
