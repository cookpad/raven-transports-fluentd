require 'fluent-logger'

require 'raven/transports'
require 'raven/error'

require 'uri'

module Raven
  module Transports
    class Fluentd < Transport

      def send_event(auth_header, data, options = {})
        unless configuration.sending_allowed?
          configuration.logger.debug("Event not sent: #{configuration.error_messages}")
        end

        conn.post('error', auth_header: auth_header, data: data, options: options, project_id: configuration.project_id)
      end

      private

      def conn
        @conn ||= begin
          uri = URI.parse(self.configuration.server)

          ::Fluent::Logger::FluentLogger.new('sentry', host: uri.host, port: uri.port)
        end
      end
    end
  end
end

# Extends Raven::Client to use Raven::Transports::Fluentd
require 'raven/transports/fluentd_ext'
