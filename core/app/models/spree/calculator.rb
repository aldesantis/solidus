# frozen_string_literal: true

module Solidus
  class Calculator < Solidus::Base
    belongs_to :calculable, polymorphic: true, optional: true

    # This method calls a compute_<computable> method. must be overriden in concrete calculator.
    #
    # It should return amount computed based on #calculable and the computable parameter
    def compute(computable)
      # Solidus::LineItem -> :compute_line_item
      computable_name = computable.class.name.demodulize.underscore
      method = "compute_#{computable_name}".to_sym
      calculator_class = self.class
      if respond_to?(method)
        send(method, computable)
      else
        raise NotImplementedError, "Please implement '#{method}(#{computable_name})' in your calculator: #{calculator_class.name}"
      end
    end

    # A description for this calculator in few words
    # @return [String] A description for the calculator
    def self.description
      model_name.human
    end

    ###################################################################

    # Returns all calculators applicable for kind of work
    def self.calculators
      Solidus::Deprecation.warn("Calling .calculators is deprecated. Please access through Rails.application.config.spree.calculators")

      Solidus::Config.environment.calculators
    end

    def to_s
      self.class.name.titleize.gsub("Calculator\/", "")
    end

    def description
      self.class.description
    end

    def available?(_object)
      true
    end
  end
end
