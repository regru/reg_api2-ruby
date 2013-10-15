require 'rake'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'yard'

GEM_ROOT = File.dirname(__FILE__).freeze

lib_path = File.expand_path('lib', GEM_ROOT)
$LOAD_PATH.unshift(lib_path)  unless $LOAD_PATH.include? lib_path

require 'reg_api2/version'

RSpec::Core::RakeTask.new

YARD::Rake::YardocTask.new do |yard|
  yard.options << "--title='reg.api2 #{RegApi2::VERSION}'"
end

task :default => :spec
