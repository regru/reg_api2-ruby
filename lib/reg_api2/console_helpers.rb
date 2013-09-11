# -*- encoding : utf-8 -*-
require 'reg_api2'

include RegApi2

# try to load defaults from ~/.regapi2
def try_lo_load_defaults
  filename = "#{ENV['HOME']}/.regapi2"
  username = 'test'
  password = 'test'

  if File.readable?(filename)
    IO.read(filename).split("\n").each do |line|
      username = $1  if line.strip =~ /^\s*username\s*\=(.+)\s*$/;
      password = $1  if line.strip =~ /^\s*password\s*\=(.+)\s*$/;
    end
  end

  RegApi2.username = username
  RegApi2.password = password
  puts "Your default username: \"#{username}\", and You can change it with \"#{filename}\"."
end

try_lo_load_defaults
