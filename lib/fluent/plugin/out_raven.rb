require 'raven'
require 'hashie'
require 'uri'

module Fluent
  class RavenOutput < BufferedOutput
    Fluent::Plugin.register_output('raven', self)

    config_param :server, :string
    config_param :ssl_verification, :bool, default: false
    config_param :timeout, :integer, default: 1
    config_param :open_timeout, :integer, default: 1
    config_param :raven_log_path, :string

    def configure(conf)
      super
      uri =  URI.parse(conf['server'])
      project_id = uri.path.slice(/\d+/)

      @base_configuration = Hashie::Mash.new(
        server:           conf['server'],
        public_key:       'not_used',
        secret_key:       'not_used',
        ssl:              uri.scheme == 'https' ? true : false,
        ssl_verification: conf['ssl_verification'],
        timeout:          conf['timeout'],
        open_timeout:     conf['open_timeout'],
      )

      Raven.configure do |config|
        config.logger = Logger.new(conf['raven_log_path'])
      end
    end

    def start
      super
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      [tag, time, record].to_msgpack
    end

    def write(chunk)
      chunk.msgpack_each do |tag, time, record|
        auth_header = record['auth_header']
        data        = record['data']
        options     = Hash[record['options'].map { |key, value| [key.to_sym, value] }] if record['options']
        project_id  = record['project_id']
        send_to_sentry(auth_header, data, project_id, options)
      end
    end

    private

    def send_to_sentry(auth_header, data, project_id, options)
      transport = ::Raven::Transports::HTTP.new(@base_configuration.merge(
        project_id: project_id,
      ))
      transport.send(auth_header, data, options)
    end

  end
end
