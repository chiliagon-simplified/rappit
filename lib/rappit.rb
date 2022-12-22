# frozen_string_literal: true

require_relative "rappit/version"

# Main module/entry point for the Rappit gem
module Rappit
  class Error < StandardError; end

  def self.hello_world
    puts "Hello World from Rappit"
  end
end
