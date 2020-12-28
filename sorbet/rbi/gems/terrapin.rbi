# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/terrapin/all/terrapin.rbi
#
# terrapin-0.6.0

module Terrapin
end
class Terrapin::OSDetector
  def arch; end
  def java?; end
  def path_separator; end
  def unix?; end
  def windows?; end
end
class Terrapin::CommandLine
  def bit_bucket; end
  def colored(text, ansi_color = nil); end
  def command(interpolations = nil); end
  def command_error_output; end
  def command_output; end
  def environment; end
  def execute(command); end
  def exit_status; end
  def initialize(binary, params = nil, options = nil); end
  def interpolate(pattern, interpolations); end
  def log(text); end
  def os_path_prefix; end
  def output; end
  def path_prefix; end
  def run(interpolations = nil); end
  def runner; end
  def runner_options; end
  def self.best_runner; end
  def self.environment; end
  def self.fake!; end
  def self.logger; end
  def self.logger=(arg0); end
  def self.path; end
  def self.path=(supplemental_path); end
  def self.runner; end
  def self.runner=(arg0); end
  def self.runner_options; end
  def self.unfake!; end
  def shell_quote(string); end
  def shell_quote_all_values(values); end
  def stringify_keys(hash); end
  def unix_path_prefix; end
  def windows_path_prefix; end
end
class Terrapin::CommandLine::Output
  def error_output; end
  def initialize(output = nil, error_output = nil); end
  def output; end
  def to_s; end
end
class Terrapin::CommandLine::MultiPipe
  def close_read; end
  def close_write; end
  def initialize; end
  def output; end
  def pipe_options; end
  def read; end
  def read_and_then(&block); end
  def read_stream(io); end
end
class Terrapin::CommandLine::BackticksRunner
  def call(command, env = nil, options = nil); end
  def self.supported?; end
  def supported?; end
  def with_modified_environment(env, &block); end
end
class Terrapin::CommandLine::ProcessRunner
  def call(command, env = nil, options = nil); end
  def self.available?; end
  def self.supported?; end
  def spawn(*args); end
  def supported?; end
  def waitpid(pid); end
end
class Terrapin::CommandLine::PosixRunner
  def call(command, env = nil, options = nil); end
  def self.available?; end
  def self.posix_spawn_gem_available?; end
  def self.supported?; end
  def spawn(*args); end
  def supported?; end
  def waitpid(pid); end
end
class Terrapin::CommandLine::PopenRunner
  def call(command, env = nil, options = nil); end
  def self.supported?; end
  def supported?; end
  def with_modified_environment(env, &block); end
end
class Terrapin::CommandLine::FakeRunner
  def call(command, env = nil, options = nil); end
  def commands; end
  def initialize; end
  def ran?(predicate_command); end
  def self.supported?; end
  def supported?; end
end
class Terrapin::CommandLineError < StandardError
end
class Terrapin::CommandNotFoundError < Terrapin::CommandLineError
end
class Terrapin::ExitStatusError < Terrapin::CommandLineError
end
class Terrapin::InterpolationError < Terrapin::CommandLineError
end
