require 'rubygems'
require 'rake'
require "bundler/gem_tasks"

APP_ROOT = File.dirname(__FILE__).freeze

lib = File.expand_path('lib', APP_ROOT)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reg_api2/version'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new

  RSpec::Core::RakeTask.new(:rcov) do |t|
    t.rcov = true
    t.ruby_opts = '-w'
    t.rcov_opts = %q[-Ilib --exclude "spec/*,gems/*"]
  end
rescue LoadError
  $stderr.puts "RSpec not available. Install it with: gem install rspec-core rspec-expectations"
end

task :default => :spec

begin
  require 'yard'

  YARD::Rake::YardocTask.new do |yard|

    version = RegApi2::VERSION
    yard.options << "--title='reg.api2 #{version}'"
  end
rescue LoadError
  $stderr.puts "Please install YARD with: gem install yard"
end
