# frozen_string_literal: true

module Solidus
  class Country < Solidus::Base
    has_many :states, -> { order(:name) }, dependent: :destroy
    has_many :addresses, dependent: :nullify
    has_many :prices, class_name: "Solidus::Price", foreign_key: "country_iso", primary_key: "iso"

    validates :name, :iso_name, presence: true

    self.whitelisted_ransackable_attributes = %w[name]

    def self.default
      if Solidus::Config.default_country_id
        Solidus::Deprecation.warn("Setting your default country via its ID is deprecated. Please set your default country via the `default_country_iso` setting.", caller)
        find_by(id: Solidus::Config.default_country_id) || find_by!(iso: Solidus::Config.default_country_iso)
      else
        find_by!(iso: Solidus::Config.default_country_iso)
      end
    end

    def self.available(restrict_to_zone: Solidus::Config[:checkout_zone])
      checkout_zone = Zone.find_by(name: restrict_to_zone)

      return checkout_zone.country_list if checkout_zone.try(:kind) == 'country'

      all
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end
  end
end
