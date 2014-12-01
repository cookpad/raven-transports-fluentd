module Raven
  module Transports
    module FluentdExt
      def transport
        @transport ||=
          case self.configuration.scheme
          when 'udp'
            Transports::UDP.new self.configuration
          when 'http', 'https'
            Transports::HTTP.new self.configuration
          when 'fluentd'
            Transports::Fluentd.new self.configuration
          else
            raise Error.new("Unknown transport scheme '#{self.configuration.scheme}'")
          end
      end
    end
  end
end

require 'raven/client'

Raven::Client.send(:prepend, Raven::Transports::FluentdExt)
