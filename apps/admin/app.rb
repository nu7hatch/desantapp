require 'core/models/signup'
require 'reusable/helpers/auth_helpers'

require 'admin/presenters/latest_signups_presenter'
require 'admin/forms/login_form'

module Airstrip
  module Admin
    class App < Reusable::Application
      # Configuration
      set :app_title, "Airstrip Admin"
      set :root, File.dirname(__FILE__)

      # Custom extensions.
      extend Reusable::EnvCondition
      extend Reusable::JSONParamsCondition
      extend Reusable::TestAction

      # Use asset pipeline.
      use Reusable::AssetPipeline, '/assets' do
        append_path File.expand_path('../../core/assets')
      end

      # Extra helpers.
      helpers Reusable::AuthHelpers

      # Actions...

      get "/" do
        if logged_in?
          erb :dashboard
        else
          status 401
          erb :login
        end
      end

      post "/session", :provides => 'json' do
        content_type "application/json"

        # Passing if already logged in.
        status 204 and return if logged_in?

        login_f = AdminLoginForm.new(*params.values_at(:login, :password))
        login_f.on_error { status 400 }
        login_f.call { |login| authenticate!(login) and redirect to("/") }.to_json
      end

      get "/logout" do
        log_out!
        redirect to("/")
      end

      before "/api/*" do
        content_type "application/json"

        unless logged_in?
          status 401
          halt({ :error => "Unauthorized" }.to_json)
        end
      end

      get "/api/signups", :provides => 'json' do
        signups_p = LatestSignupsPresenter.new(params[:page])
        signups_p.call.to_json
      end

      get "/api/locations", :provides => 'json' do
        
      end

      get "/api/referrers", :provides => 'json' do
        
      end
    end
  end
end
