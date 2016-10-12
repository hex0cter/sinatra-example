require 'json'

module App
  module Controller
    # Main logger
    class Logger
      def initialize(app, logger)
        @app = app
        @logger = logger
      end

      def call(env)
        began_at = Time.now
        status, header, body = @app.call(env)
        log(env, status, began_at)
        [status, header, body]
      end

      def log(env, status, began_at)
        now = Time.now
        begin
          user = env['rack.session'][:user][:name]
        rescue NoMethodError
          user = env['REMOTE_ADDR']
        end

        duration = now - began_at

        # Transform the log to JSON
        message = {
          timestamp: began_at,
          user: user,
          request_method: env['REQUEST_METHOD'],
          path_info: env['PATH_INFO'],
          parameters: env['rack.input'].read,
          query_string: env['QUERY_STRING'].empty? ? '' : '?' + env['QUERY_STRING'],
          status_code: status.to_s[0..3],
          duration: duration
        }.to_json

        logger = @logger || env['RACK_ERRORS']
        if logger.respond_to?(:write)
          logger.write("#{message}\n")
        else
          logger << message
        end
      end
    end
  end
end
