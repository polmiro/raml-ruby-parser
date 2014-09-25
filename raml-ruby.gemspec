# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raml/version'

Gem::Specification.new do |spec|
  spec.name          = "raml-ruby"
  spec.version       = Raml::VERSION
  spec.authors       = ["polmiro"]
  spec.email         = ["polmiro@gmail.com"]
  spec.description   = "Parser for the RAML language"
  spec.summary       = "Parser for the RAML language"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "virtus"
  spec.add_development_dependency "activemodel", "~> 4.1.6"
  spec.add_development_dependency "activesupport", "~> 4.1.6"
end
