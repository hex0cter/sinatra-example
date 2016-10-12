require 'rubygems'
require 'bundler'

Bundler.require

module App
  class Runner < Sinatra::Application
    configure do
      enable :sessions
      set :session_secret, '*&(^B234'

      disable :method_override
      disable :static
    end

    not_found do
      status 404
      erb :not_found
    end

    error do
      status 500
      'Server error'
    end

    set :root, File.dirname(__FILE__)
    set :views, File.expand_path('../app/views', __FILE__)

    set :bind, '0.0.0.0'
    set :port, 9494

    use Controller::Logger, STDOUT

    use Rack::Deflater
    use Routes::Ping
  end
end