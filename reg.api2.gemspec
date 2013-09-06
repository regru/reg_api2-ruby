# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reg_api2/version'

Gem::Specification.new do |spec|
  spec.name          = "reg.api2"
  spec.version       = RegApi2::VERSION
  spec.authors       = ["Akzhan Abdulin"]
  spec.email         = ["akzhan.abdulin@gmail.com"]
  spec.description   = %q{REG.API v2 Implementation}
  spec.summary       = %q{REG.API v2 Implementation}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
