module Reusable
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
