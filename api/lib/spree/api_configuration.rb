# typed: strict
# frozen_string_literal: true

module Spree
  class ApiConfiguration < Preferences::Configuration
    preference :requires_authentication, :boolean, default: true
  end
end
