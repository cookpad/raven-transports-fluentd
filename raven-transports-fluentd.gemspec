# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "raven-transports-fluentd"
  spec.version       = '0.2.2'
  spec.authors       = ["Naoto Takai", "Kohei Suzuki"]
  spec.email         = ["takai@cookpad.com", "kohei-suzuki@cookpad.com"]
  spec.summary       = %q{Send error logs to sentry via fluentd.}
  spec.description   = %q{Send error logs to sentry via fluentd.}
  spec.homepage      = "https://github.com/cookpad/raven-transports-fluentd"
  spec.license       = 'Apache License, Version 2.0'

  spec.files         = `git ls-files -z`.split("\x0").select { |path| path !~ %r{\Atest/dummy} }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "fluent-logger"
  spec.add_dependency "sentry-raven", ">= 2.7.0"
end
