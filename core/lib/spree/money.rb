# frozen_string_literal: true

module Solidus
  # Solidus::Money is a relatively thin wrapper around Monetize which handles
  # formatting via Solidus::Config.
  class Money
    include Comparable
    DifferentCurrencyError = Class.new(StandardError)
    RUBY_NUMERIC_STRING = /\A-?\d+(\.\d+)?\z/

    class <<self
      attr_accessor :default_formatting_rules

      def parse(amount, currency = Solidus::Config[:currency])
        new(parse_to_money(amount, currency))
      end

      # @api private
      def parse_to_money(amount, currency)
        ::Monetize.parse(amount, currency)
      end
    end
    self.default_formatting_rules = {
      # Ruby money currently has this as false, which is wrong for the vast
      # majority of locales.
      sign_before_symbol: true
    }

    attr_reader :money

    delegate :cents, :currency, :to_d, :zero?, to: :money

    # @param amount [Money, #to_s] the value of the money object
    # @param options [Hash] the default options for formatting the money object See #format
    def initialize(amount, options = {})
      if amount.is_a?(::Money)
        @money = amount
      else
        currency = (options[:currency] || Solidus::Config[:currency])
        if amount.to_s =~ RUBY_NUMERIC_STRING
          @money = Monetize.from_string(amount, currency)
        else
          @money = Solidus::Money.parse_to_money(amount, currency)
          Solidus::Deprecation.warn <<-WARN.squish, caller
            Solidus::Money was initialized with #{amount.inspect}, which will not be supported in the future.
            Instead use Solidus::Money.new(#{@money.to_s.inspect}, options) or Solidus::Money.parse(#{amount.inspect})
          WARN
        end
      end
      @options = Solidus::Money.default_formatting_rules.merge(options)
    end

    # @return [String] the value of this money object formatted according to
    #   its options
    def to_s
      format
    end

    # @param options [Hash, String] the options for formatting the money object
    # @option options [Boolean] with_currency when true, show the currency
    # @option options [Boolean] no_cents when true, round to the closest dollar
    # @option options [String] decimal_mark the mark for delimiting the
    #   decimals
    # @option options [String, false, nil] thousands_separator the character to
    #   delimit powers of 1000, if one is desired, otherwise false or nil
    # @option options [Boolean] sign_before_symbol when true the sign of the
    #   value comes before the currency symbol
    # @option options [:before, :after] symbol_position the position of the
    #   currency symbol
    # @return [String] the value of this money object formatted according to
    #   its options
    def format(options = {})
      @money.format(@options.merge(options))
    end

    # @note If you pass in options, ensure you pass in the { html_wrap: true } as well.
    # @param options [Hash] additional formatting options
    # @return [String] the value of this money object formatted according to
    #   its options and any additional options, by default with html_wrap.
    def to_html(options = { html_wrap: true })
      output = format(options)
      # Maintain compatibility by checking html option renamed to html_wrap.
      if options[:html] || options[:html] == false
        Solidus::Deprecation.warn <<-WARN.squish, caller
          Solidus::Money#to_html called with Solidus::Money#to_html(html: #{options[:html]}),
          which will not be supported in the future.
          Instead use :html_wrap e.g. Solidus::Money#to_html(html_wrap: #{options[:html]})
        WARN
      end
      if options[:html_wrap] || options[:html]
        output = output.html_safe
      end
      output
    end

    # (see #to_s)
    def as_json(*)
      to_s
    end

    def <=>(other)
      if !other.respond_to?(:money)
        raise TypeError, "Can't compare #{other.class} to Solidus::Money"
      end
      if currency != other.currency
        # By default, ::Money will try to run a conversion on `other.money` and
        # try a comparison on that. We do not want any currency conversion to
        # take place so we'll catch this here and raise an error.
        raise(
          DifferentCurrencyError,
          "Can't compare #{currency} with #{other.currency}"
        )
      end
      @money <=> other.money
    end

    # Delegates comparison to the internal ruby money instance.
    #
    # @see http://www.rubydoc.info/gems/money/Money/Arithmetic#%3D%3D-instance_method
    def ==(other)
      raise TypeError, "Can't compare #{other.class} to Solidus::Money" if !other.respond_to?(:money)
      @money == other.money
    end

    def -(other)
      raise TypeError, "Can't subtract #{other.class} to Solidus::Money" if !other.respond_to?(:money)
      self.class.new(@money - other.money)
    end

    def +(other)
      raise TypeError, "Can't add #{other.class} to Solidus::Money" if !other.respond_to?(:money)
      self.class.new(@money + other.money)
    end
  end
end
