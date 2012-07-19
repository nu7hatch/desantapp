module Reusable
  # Public: Provides action which runs frontend tests suite.
  #
  # Usage
  #
  #   class App < Sinatra::Application
  #     include Reusable::EnvCondition
  #     include Reusable::TestAction
  #   end
  #
  module TestAction
    def self.extended(app)
      app.get "/tests", :only_env => ['development', 'test'] do
        erb :tests, :layout => false
      end
    end
  end
end
