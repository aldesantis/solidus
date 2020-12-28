# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/handlebars_assets/all/handlebars_assets.rbi
#
# handlebars_assets-0.23.8

module HandlebarsAssets
  def self.add_to_asset_versioning(sprockets_environment); end
  def self.configure; end
  def self.path; end
  def self.register_extensions(sprockets_environment); end
end
class HandlebarsAssets::Engine < Rails::Engine
end
module HandlebarsAssets::Config
  def amd=(arg0); end
  def amd?; end
  def amd_with_template_namespace; end
  def amd_with_template_namespace=(arg0); end
  def chomp_underscore_for_partials=(arg0); end
  def chomp_underscore_for_partials?; end
  def compiler; end
  def compiler=(arg0); end
  def compiler_path; end
  def compiler_path=(arg0); end
  def ember=(arg0); end
  def ember?; end
  def ember_extensions; end
  def generate_known_helpers_hash; end
  def generate_options; end
  def haml_available?; end
  def haml_enabled=(arg0); end
  def haml_enabled?; end
  def haml_options; end
  def haml_options=(arg0); end
  def hamlbars_extensions; end
  def hamlbars_extensions=(arg0); end
  def handlebars_amd_path; end
  def handlebars_amd_path=(arg0); end
  def handlebars_extensions; end
  def handlebars_extensions=(arg0); end
  def known_helpers; end
  def known_helpers=(arg0); end
  def known_helpers_only; end
  def known_helpers_only=(arg0); end
  def multiple_frameworks=(arg0); end
  def multiple_frameworks?; end
  def options; end
  def options=(arg0); end
  def patch_files; end
  def patch_files=(arg0); end
  def patch_path; end
  def patch_path=(arg0); end
  def path_prefix; end
  def path_prefix=(arg0); end
  def precompile; end
  def precompile=(arg0); end
  def self.configure; end
  def slim_available?; end
  def slim_enabled=(arg0); end
  def slim_enabled?; end
  def slim_options; end
  def slim_options=(arg0); end
  def slimbars_extensions; end
  def slimbars_extensions=(arg0); end
  def template_namespace; end
  def template_namespace=(arg0); end
  extend HandlebarsAssets::Config
end
module HandlebarsAssets::Unindent
  def unindent(heredoc); end
end
class HandlebarsAssets::HandlebarsTemplate < Tilt::Template
  def evaluate(scope, locals, &block); end
  def initialize_engine; end
  def prepare; end
  def renderer; end
  def self.default_mime_type; end
end
class HandlebarsAssets::HandlebarsProcessor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
class HandlebarsAssets::NoOpEngine
  def initialize(data); end
  def render(*args); end
end
class HandlebarsAssets::HandlebarsRenderer
  def choose_engine(data); end
  def compile(source); end
  def compile_default(source); end
  def compile_ember(source); end
  def initialize(options); end
  def self.initialize_engine; end
  include HandlebarsAssets::Unindent
end
class HandlebarsAssets::HandlebarsRenderer::TemplatePath
  def check_extension(ext); end
  def initialize(path); end
  def is_ember?; end
  def is_haml?; end
  def is_partial?; end
  def is_slim?; end
  def name; end
  def relative_path; end
  def template_name; end
end
