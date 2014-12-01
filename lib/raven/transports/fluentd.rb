require 'fluent-logger'

require 'raven/transports'
require 'raven/error'

require 'uri'

module Raven
  module Transports
    class Fluentd < Transport

      def send(auth_header, data, options = {})
        conn.post('error', auth_header: auth_header, data: data, options: options, project_id: configuration.project_id)
      end

      private

      def conn
        verify_configuration

        @conn ||= begin
          uri = URI.parse(self.configuration.server)

          ::Fluent::Logger::FluentLogger.new('sentry', host: uri.host, port: uri.port)
        end
      end

      def verify_configuration
        super
      end

    end
  end
end

# Extends Raven::Client to use Raven::Transports::Fluentd
require 'raven/transports/fluentd_ext'
