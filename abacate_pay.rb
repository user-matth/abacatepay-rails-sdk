# frozen_string_literal: true

require "abacate_pay/version"
require "abacate_pay/configuration"

# Main module for the AbacatePay SDK
#
# This module provides the entry point and configuration for the AbacatePay SDK.
# It allows setting up API credentials and customizing the client behavior.
#
# @example Basic configuration
#   AbacatePay.configure do |config|
#     config.api_token = "your-token"
#     config.environment = :sandbox
#   end
#
# @api public
module AbacatePay
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class ApiError < Error; end

  class << self
    # Gets the global configuration
    # @return [AbacatePay::Configuration]
    attr_accessor :configuration
  end

  # Configures the SDK with the given block
  #
  # @example
  #   AbacatePay.configure do |config|
  #     config.api_token = "your-token"
  #   end
  #
  # @yield [config] Configuration object that can be modified
  # @yieldparam config [AbacatePay::Configuration] The configuration object
  # @return [void]
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    configuration.validate!
  end

  # Resets the configuration to default values
  #
  # @return [void]
  def self.reset_configuration!
    self.configuration = Configuration.new
  end
end

# Load all components
Dir[File.join(__dir__, 'abacate_pay', '**', '*.rb')].sort.each { |file| require file }