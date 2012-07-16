module Reusable
  module TestAction
    def self.extended(app)
      app.get "/tests", :only_env => ['development', 'test'] do
        erb :tests, :layout => false
      end
    end
  end
end
