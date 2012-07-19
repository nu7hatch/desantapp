require 'reusable/helpers/auth_helpers'
require 'core/models/signup'

require_rel 'presenters'
require_rel 'forms'
require_rel 'loggers'

module Airstrip
  module Admin
    class App < Reusable::Application
      # Configuration
      set :app_title, "Airstrip Admin"
      set :root, File.dirname(__FILE__)

      # Custom extensions.
      extend Reusable::EnvCondition
      extend Reusable::SimpleAuthCondition
      extend Reusable::JSONParamsCondition
      extend Reusable::TestAction

      # Use asset pipeline.
      use Reusable::AssetPipeline, '/assets' do
        append_paths(%w(app libs styles).map { |sub|
          File.expand_path("../../core/assets/#{sub}", __FILE__)
        })
      end

      # Extra helpers.
      helpers Reusable::AuthHelpers

      # Actions...

      %w{/ /signups /referers /locations/cities /locations/countries}.each do |path|
        get path do
          unless logged_in?
            status 401
            redirect to('/login')
          end
          
          erb :default
        end
      end

      get "/login" do
        redirect to('/admin') if logged_in?
        erb :default
      end

      post "/session", :provides => 'json', :json_data_params => true do
        content_type "application/json"

        return redirect(to('/session')) if logged_in?

        attrs = params.values_at(:login, :password) + [ request.ip ]
        login_f = LoginForm.new(*attrs)
        login_f.on_error { status 400 }
        login_f.call { |login, token| authenticate!(login, token) }.to_json
      end

      get "/session", :provides => 'json' do
        if logged_in?
          auth_data.to_json
        else
          status 401
          { :error => "Unauthorized" }.to_json
        end
      end

      get "/logout" do
        log_out!
        redirect to("/")
      end

      get "/signups.csv", :provides => 'csv', :auth => true do
        content_type "text/csv"
        headers "Content-Disposition" => "attachment;filename=signups.csv"

        LatestSignupsPresenter.new.mapped_signups.to_csv
      end

      before "/api/*" do
        content_type "application/json"

        unless logged_in?
          status 401
          halt({ :error => "Unauthorized" }.to_json)
        end
      end

      get "/api/signups", :provides => 'json' do
        LatestSignupsPresenter.new(params[:page]).call.to_json
      end

      get "/api/cities", :provides => 'json' do
        cities_p = CitiesPresenter.new(params[:page])
        cities_p.call.to_json
      end

      get "/api/cities/map", :provides => 'json' do
        CitiesPresenter.new.mercator_data.to_json
      end

      get "/api/countries", :provides => 'json' do
        CountriesPresenter.new(params[:page]).call.to_json
      end

      get "/api/countries/map", :provides => 'json' do
        CountriesPresenter.new.mercator_data.to_json
      end

      get "/api/referers", :provides => 'json' do
        ReferersPresenter.new(params[:page]).call.to_json
      end
    end
  end
end
