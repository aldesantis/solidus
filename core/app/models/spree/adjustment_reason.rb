# frozen_string_literal: true

module Solidus
  class AdjustmentReason < Solidus::Base
    has_many :adjustments, inverse_of: :adjustment_reason

    validates :name, presence: true, uniqueness: { case_sensitive: false, allow_blank: true }
    validates :code, presence: true, uniqueness: { case_sensitive: false, allow_blank: true }

    scope :active, -> { where(active: true) }
  end
end
