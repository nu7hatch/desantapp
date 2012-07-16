module Reusable
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
