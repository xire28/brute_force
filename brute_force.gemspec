# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brute_force/version'

Gem::Specification.new do |spec|
  spec.name          = "brute_force"
  spec.version       = BruteForce::VERSION
  spec.authors       = ["Pagliaro Alexandre"]
  spec.email         = ["pagliaro.alexandre@hotmail.com"]

  spec.summary       = 'Simple brute force generator'
  spec.description   = 'Simple, fast and highly configurable brute force generator for ruby'
  spec.homepage      = "https://github.com/xire28/brute_force"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "radix", "~> 2.2"
end
