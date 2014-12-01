# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "raven-transports-fluentd"
  spec.version       = '0.0.1'
  spec.authors       = ["Naoto Takai", "Kohei Suzuki"]
  spec.email         = ["takai@cookpad.com", "kohei-suzuki@cookpad.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = 'Apache License, Version 2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "fluent-logger"
  spec.add_dependency "hashie"
  spec.add_dependency "sentry-raven", "~> 0.10.1"
end
