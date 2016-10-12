
module App
  module Routes
    class Ping < Base
      get '/' do
        erb :ping
      end
    end
  end
end