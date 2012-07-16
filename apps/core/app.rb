require 'core/models/signup'
require 'core/services/signup_service'

module Airstrip
  module Core
    class App < Reusable::Application
      # Configuration.
      set :app_title, "Airstrip"
      set :root, File.dirname(__FILE__)
      
      # Custom extensions.
      extend Reusable::EnvCondition
      extend Reusable::JSONParamsCondition
      extend Reusable::TestAction

      # Use asset pipeline.
      use Reusable::AssetPipeline, '/assets'

      # Actions...

      get "/" do
        erb :index
      end

      post "/signup", :provides => 'json', :json_data_params => true do
        content_type "application/json"

        signup_s = SignupService.new(self)
        signup_s.on_error { status 400 }
        signup_s.call.to_json
      end
    end
  end
end
