require 'rake'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'yard'

APP_ROOT = File.dirname(__FILE__).freeze

lib = File.expand_path('lib', APP_ROOT)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'reg_api2/version'

RSpec::Core::RakeTask.new

YARD::Rake::YardocTask.new do |yard|
  yard.options << "--title='reg.api2 #{RegApi2::VERSION}'"
end

task :default => :spec
