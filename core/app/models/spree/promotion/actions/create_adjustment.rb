# typed: false
# frozen_string_literal: true

module Spree
  class Promotion < Spree::Base
    module Actions
      class CreateAdjustment < PromotionAction
        include Spree::CalculatedAdjustments
        include Spree::AdjustmentSource

        has_many :adjustments, as: :source

        delegate :eligible?, to: :promotion

        before_validation :ensure_action_has_calculator
        before_destroy :remove_adjustments_from_incomplete_orders
        before_discard :remove_adjustments_from_incomplete_orders

        # Creates the adjustment related to a promotion for the order passed
        # through options hash
        #
        # Returns `true` if an adjustment is applied to an order,
        # `false` if the promotion has already been applied.
        def perform(options = {})
          order = options[:order]
          return if promotion_credit_exists?(order)

          amount = compute_amount(order)
          order.adjustments.create!(
            amount: amount,
            order: order,
            source: self,
            promotion_code: options[:promotion_code],
            label: I18n.t('spree.adjustment_labels.order', promotion: Spree::Promotion.model_name.human, promotion_name: promotion.name)
          )
          true
        end

        # Ensure a negative amount which does not exceed the sum of the order's
        # item_total and ship_total
        def compute_amount(calculable)
          amount = calculator.compute(calculable)
          if !amount.is_a?(BigDecimal)
            Spree::Deprecation.warn "#{calculator.class.name}#compute returned #{amount.inspect}, it should return a BigDecimal"
          end
          amount ||= BigDecimal(0)
          amount = amount.abs
          [(calculable.item_total + calculable.ship_total), amount].min * -1
        end

        # Removes any adjustments generated by this action from the order.
        # @param order [Spree::Order] the order to remove the action from.
        # @return [void]
        def remove_from(order)
          order.adjustments.each do |adjustment|
            if adjustment.source == self
              order.adjustments.destroy(adjustment)
            end
          end
        end

        private

        # Tells us if there if the specified promotion is already associated with the line item
        # regardless of whether or not its currently eligible. Useful because generally
        # you would only want a promotion action to apply to order no more than once.
        #
        # Receives an adjustment +source+ (here a PromotionAction object) and tells
        # if the order has adjustments from that already
        def promotion_credit_exists?(adjustable)
          adjustments.where(adjustable_id: adjustable.id).exists?
        end

        def ensure_action_has_calculator
          return if calculator
          self.calculator = Calculator::FlatPercentItemTotal.new
        end
      end
    end
  end
end
