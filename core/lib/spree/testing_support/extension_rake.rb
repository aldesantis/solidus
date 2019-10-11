# frozen_string_literal: true

require 'spree/testing_support/common_rake'

desc "Generates a dummy app for testing an extension"
namespace :extension do
  task :test_app, [:user_class] do |_t, _args|
    Solidus::DummyGeneratorHelper.inject_extension_requirements = true
    Rake::Task['common:test_app'].invoke
  end
end
