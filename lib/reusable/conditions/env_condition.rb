module Reusable
  # Public: Provides a Sinatra condition to define environment
  # specific actions.
  #
  # Usage
  #
  #   class App < Sinatra::Application
  #     include Reusable::EnvCondition
  #
  #     get "/tests", :env_only => %w{development test} do
  #       erb :tests_suite, :layout => false
  #     end
  #   end
  #
  module EnvCondition
    def self.extended(app)
      app.set(:only_env) do |*envs|
        condition do
          envs.any? { |env| RACK_ENV == env.to_s }
        end
      end
    end
  end
end
