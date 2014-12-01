# Raven::Transports::Fluentd

Send error logs to [sentry](https://github.com/getsentry/sentry) via [fluentd](https://github.com/fluent/fluentd) .

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'raven-transports-fluentd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install raven-transports-fluentd

## Usage

config/initializers/raven.rb

```ruby
require 'raven'
require 'raven/transports/fluentd'

Raven.configure do |config|
  config.dsn = "fluentd://#{ENV['SENTRY_PUBLIC_KEY']}:#{ENV['SENTRY_SECRET_KEY']}@localhost:24224/2"
end
```

## Contributing

1. Fork it ( https://github.com/cookpad/raven-transports-fluent/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
