require 'raven'
require 'raven/transports/fluentd'

Raven.configure do |config|
  config.dsn = "fluentd://#{ENV['SENTRY_PUBLIC_KEY']}:#{ENV['SENTRY_SECRET_KEY']}@localhost:24224/2"
end
