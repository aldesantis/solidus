# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/factory_bot_rails/all/factory_bot_rails.rbi
#
# factory_bot_rails-4.11.1

module FactoryBotRails
end
module FactoryBotRails::Generators
end
class FactoryBotRails::Generators::RSpecGenerator
  def factory_bot_directory; end
  def fixture_replacement_setting; end
  def initialize(generators); end
  def run; end
end
class FactoryBotRails::Generators::NonRSpecGenerator
  def initialize(generators); end
  def run; end
  def test_framework; end
end
class FactoryBotRails::Generators::NullGenerator
  def initialize(generators); end
  def run; end
end
class FactoryBotRails::Generator
  def factory_bot_disabled?; end
  def generator; end
  def initialize(config); end
  def rails_options; end
  def run; end
  def test_framework; end
end
module FactoryBot
end
class FactoryBot::Railtie < Rails::Railtie
end
