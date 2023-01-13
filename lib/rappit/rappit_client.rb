# frozen_string_literal: true

require_relative 'o2auth/o2_auth'
require_relative 'o2auth/auth_scopes'

module Rappit
  # RappitClient executes API calls to Reddit API
  class RappitClient
    attr_reader :config

    def initialize
      @config = Rappit.config
    end

    def generate_auth_scope_url(scope)
      O2AuthApi.new(config).generate_auth_scope(scope)
    end

    def generate_access_token_for_scope(code)
      O2AuthApi.new(config).generate_access_token(code)
    end
  end
end
