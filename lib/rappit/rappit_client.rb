# frozen_string_literal: true

require_relative 'o2auth/o2_auth'
require_relative 'o2auth/auth_scopes'

module Rappit
  # RappitClient executes API calls to Reddit API
  class RappitClient
    attr_reader :config

    def initialize(config_arg = {})
      @config = Rappit.config.custom_configuration(config_arg)
    end

    def generate_auth_scope_url
      O2AuthApi.new(config).generate_auth_scope(AuthScopes::IDENTITY)
    end
  end
end
