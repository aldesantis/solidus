# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/state_machines-activemodel/all/state_machines-activemodel.rbi
#
# state_machines-activemodel-0.7.1

module StateMachines
end
module StateMachines::Integrations
end
module StateMachines::Integrations::ActiveModel
  def add_callback(type, options, &block); end
  def add_events(*arg0); end
  def add_states(*arg0); end
  def ancestors_for(klass); end
  def around_validation(object); end
  def callback_terminator; end
  def default_error_message_options(_object, _attribute, message); end
  def define_action_helpers; end
  def define_state_accessor; end
  def define_state_initializer; end
  def define_validation_hook; end
  def errors_for(object); end
  def i18n_scope(klass); end
  def invalidate(object, attribute, message, values = nil); end
  def reset(object); end
  def runs_validations_on_action?; end
  def self.matching_ancestors; end
  def supports_validations?; end
  def translate(klass, key, value); end
  extend StateMachines::Integrations::Base::ClassMethods
  include StateMachines::Integrations::Base
end
