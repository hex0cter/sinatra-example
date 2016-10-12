require 'sinatra'

module App
  module Routes
    # Base routing
    class Base < Sinatra::Application
      enable :session

      # set folder for templates to ../views, but make the path absolute
      set :views, File.expand_path('../../views', __FILE__)
      set :public_folder, File.expand_path('../../../public', __FILE__)
      set :partial_template_engine, :erb

      enable :partial_underscores
    end
  end
end
