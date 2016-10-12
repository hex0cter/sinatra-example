
module App
  module Routes
    class Posts < Base
      get '/' do
        erb :oops
      end
    end
  end
end