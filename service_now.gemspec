# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_now/version'

Gem::Specification.new do |spec|
  spec.name          = "service_now"
  spec.version       = ServiceNow::VERSION
  spec.authors       = ["Diego Carrion"]
  spec.email         = ["dc.rec1@gmail.com"]

  spec.summary       = %q{Client for the Service Now API}
  spec.homepage      = "https://github.com/VelocityCloud/service_now"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
