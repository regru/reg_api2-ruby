# -*- encoding : utf-8 -*-
module RegApi2
  # Runs Interactive Ruby Shell
  class Console
    # Gem root.
    GEM_ROOT = File.expand_path("../..", File.dirname(__FILE__)).freeze

    # Runs irb with our console helpers.
    def self.run!
      Kernel.exec("irb --readline -I #{File.join(GEM_ROOT, 'lib')} -r reg_api2/console_helpers")
    end
  end
end

RegApi2::Console.run!
