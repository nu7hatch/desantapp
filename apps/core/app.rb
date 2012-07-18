require 'core/models/signup'
require 'core/services/signup_service'
require 'uri'

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

      before do
        discover_referer
      end

      get "/" do
        erb :index
      end

      post "/signup", :provides => 'json', :json_data_params => true do
        content_type "application/json"

        signup_s = SignupService.new(self)
        signup_s.on_error { status 400 }
        signup_s.call.to_json
      end

      # Custom filters.

      def discover_referer
        referer = URI.parse(request.env['HTTP_REFERER'])
        
        if referer.host != request.host
          session[:referer] = referer.to_s
        end
      rescue URI::InvalidURIError
      end
    end
  end
end
