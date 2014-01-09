# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reg_api2/version'

Gem::Specification.new do |spec|
  spec.name          = "reg.api2"
  spec.version       = RegApi2::VERSION.dup
  spec.authors       = ["Akzhan Abdulin"]
  spec.email         = ["akzhan.abdulin@gmail.com"]
  spec.description   = %q{REG.API v2 Implementation}
  spec.summary       = %q{REG.API v2 Implementation}
  spec.homepage      = "https://regru.github.com/reg_api2-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.has_rdoc      = 'yard'

  spec.add_runtime_dependency "yajl-ruby", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "machinist"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "redcarpet", "~> 3.0"
  spec.add_development_dependency "yard-redcarpet-ext", "~> 0.0.3"
end
