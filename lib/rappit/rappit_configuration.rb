# frozen_string_literal: true

module Rappit
  # Configuration options
  # client_id, client_secret
  class RappitConfiguration
    RESPONSE_TYPE = 'code'

    attr_accessor :client_id, :client_secret, :redirect_uri, :open_browser_from_cmd_line, :response_type

    def self.setup
      new.tap do |instance|
        instance.response_type = RESPONSE_TYPE
        yield(instance) if block_given?
      end
    end

    # Edit config
    def custom_configuration(hash)
      dup.tap do |instance|
        hash.each do |option, value|
          instance.public_send("#{option}=", value)
        end
      end
    end
  end
end
