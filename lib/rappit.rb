# frozen_string_literal: true

require 'forwardable'

require_relative 'rappit/version'
require_relative 'rappit/o2auth/o2_auth'
require_relative 'rappit/o2auth/auth_scopes'
require_relative 'rappit/rappit_configuration'
require_relative 'rappit/rappit_client'

# Main module/entry point for the Rappit gem
module Rappit
  class Error < StandardError; end

  @config = Rappit::RappitConfiguration.setup
  TEST_CONFIG = {
    client_id: 'kXvgQdi8DiIVXnRfeKAN3A',
    client_secret: 'L5ef9hHpiRpTgAumgtOS4b8gNcRzew',
    redirect_uri: 'http://localhost:3000/auth',
    open_browser_from_cmd_line: true
  }.freeze

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :client_id, :client_id=
    def_delegators :@config, :client_secret, :client_secret=
    def_delegators :@config, :redirect_uri, :redirect_uri=

    def hello_world
      puts 'Hello World from Rappit'
    end

    def auth_example
      client = Rappit::RappitClient.new(TEST_CONFIG)
      client.generate_auth_scope_url
    end
end
end
