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
      next  if line =~ /\A\s*#/ # skip comments
      if line !~ /\A\s*(\w+)\s*\=(.+)\s*\z/
        $stderr.puts "#{filename}: We expect key=value string but got \"#{line}\""
        exit 1
      end
      name, value = $1, $2
      unless props.include?(name)
        $stderr.puts "#{filename}: Unknown name: \"#{name}\", we know only #{props.join(', ')}"
        exit 1
      end
      RegApi2.send("#{name}=", value)
    end
  end

  puts "Your default username: \"#{RegApi2.username}\", and You can change it with \"#{filename}\"."
end

try_lo_load_defaults
