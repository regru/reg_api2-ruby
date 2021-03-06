# -*- encoding : utf-8 -*-
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

begin
  require 'coveralls'
  Coveralls.wear!
rescue LoadError
end

require 'faker'
require 'machinist'
require 'rspec/core'
require 'rspec/collection_matchers'

require 'i18n'
I18n.enforce_available_locales = false

require 'reg_api2'

class RegApi2::Entity::EntityBase
  extend Machinist::Machinable
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before(:all) do
    RegApi2.username = 'test'
    RegApi2.password = 'test'
    RegApi2.lang = 'ru'
  end
end
