# frozen_string_literal: true

module Solidus
  class ReturnReason < Solidus::Base
    include Solidus::NamedType

    has_many :return_authorizations

    def self.reasons_for_return_items(return_items)
      # Only allow an inactive reason if it's already associated to a return item
      active | return_items.map(&:return_reason).compact
    end
  end
end
