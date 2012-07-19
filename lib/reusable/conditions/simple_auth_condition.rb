module Reusable
  # Public: Provides dummy authentication combined with AuthHelpers.
  #
  # Usage
  #
  #   class App < Sinatra::Application
  #     include SimpleAuthCondition
  #
  #     get "/admin/foo", :auth => true do
  #       erb "Something only admin can see..."
  #     end
  #
  module SimpleAuthCondition
    def self.extended(app)
      app.set(:auth) do |*envs|
        condition do
          unless logged_in?
            status 401
            halt("Unauthorized")
          end
        end
      end
    end
  end
end
