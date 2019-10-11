# frozen_string_literal: true

require 'spree/api/config'

module Solidus
  module Api
    class Engine < Rails::Engine
      isolate_namespace Solidus
      engine_name 'spree_api'

      # Leave initializer empty for backwards-compatability. Other apps
      # might still rely on this event.
      initializer "spree.api.environment", before: :load_config_initializers do; end
    end
  end
end
