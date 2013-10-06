# -*- encoding : utf-8 -*-
require 'reg_api2'

include RegApi2

# Try to load defaults from ~/.regapi2
def try_lo_load_defaults
  filename = "#{ENV['HOME']}/.regapi2"
  props = %w[ username password lang pem pem_password ca_cert_path ]

  if File.readable?(filename)
    IO.read(filename).split("\n").each do |line|
      line.strip!
      props.each do |prop|
        RegApi2.send("#{prop}=", $1)  if line =~ /\A\s*#{Regexp.escape(prop)}\s*\=(.+)\s*\z/;
      end
    end
  end

  puts "Your default username: \"#{RegApi2.username}\", and You can change it with \"#{filename}\"."
end

try_lo_load_defaults
