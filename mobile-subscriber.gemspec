# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobile_subscriber/version'

Gem::Specification.new do |spec|
  spec.name          = "mobile-subscriber"
  spec.version       = MobileSubscriber::VERSION
  spec.authors       = ["Roberto Quintanilla"]
  spec.email         = ["roberto.quintanilla@gmail.com"]
  spec.summary       = %q{Mobile MSISDN detection & validation.}
  spec.description   = %q{Mobile MSISDN detection & validation. Only useful whenever your'e a Mobile Operator 3rd Party and receive MSISDN headers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler",      "~> 1.7"
  spec.add_development_dependency "rake",         "~> 10.0"
  spec.add_development_dependency "rspec",        "~> 3.0"
  spec.add_development_dependency "rack-test",    "~> 0.6"
  spec.add_development_dependency "factory_girl", "~> 4.5"
end
