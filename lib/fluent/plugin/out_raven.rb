require 'raven'

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

      @base_configuration = Raven::Configuration.new
      @base_configuration.server = conf['server']
      @base_configuration.public_key = 'not_used'
      @base_configuration.secret_key = 'not_used'
      @base_configuration.ssl_verification = conf['ssl_verification']
      @base_configuration.timeout = conf['timeout']
      @base_configuration.open_timeout = conf['open_timeout']

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
      config = @base_configuration.dup
      config.project_id = project_id
      transport = ::Raven::Transports::HTTP.new(config)
      transport.send(auth_header, data, options)
    end

  end
end
