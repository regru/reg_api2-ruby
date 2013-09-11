# -*- encoding : utf-8 -*-
module RegApi2
  # Runs Interactive Ruby Shell
  class Console
    APP_ROOT = File.expand_path("../..", File.dirname(__FILE__)).freeze

    def self.run!
      Kernel.exec("irb --readline -I #{File.join(APP_ROOT, 'lib')} -r reg_api2/console_helpers")
    end
  end
end

RegApi2::Console.run!