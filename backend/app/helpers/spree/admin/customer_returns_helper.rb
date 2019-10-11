# frozen_string_literal: true

module Solidus
  module Admin
    module CustomerReturnsHelper
      def reimbursement_types
        @reimbursement_types ||= Solidus::ReimbursementType.accessible_by(current_ability, :read).active
      end
    end
  end
end
