# frozen_string_literal: true

require "abacate_pay/version"
require "abacate_pay/configuration"

# Main module for AbacatePay SDK integration
module AbacatePay
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class ApiError < Error; end

  class << self
    # Gets or sets the global configuration
    attr_accessor :configuration
  end

  # Configures the SDK
  #
  # @example
  #   AbacatePay.configure do |config|
  #     config.api_token = "your-token-here"
  #     config.environment = :sandbox
  #   end
  #
  # @yield [config] Configuration object
  # @return [void]
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    configuration.validate!
  end

  # Resets the configuration to defaults
  #
  # @return [void]
  def self.reset!
    self.configuration = Configuration.new
  end
end

# Autoload all components
Dir[File.join(__dir__, "abacate_pay", "**", "*.rb")].sort.each { |file| require file }