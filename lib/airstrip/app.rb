require 'airstrip/helpers/auth_helpers'

module Airstrip
  class App < Sinatra::Application
    set :app_title, "Airstrip"
    set :root, AIRSTRIP_PATH
    set :public_folder, File.join(AIRSTRIP_PATH, 'front/static')
    set :views, File.join(AIRSTRIP_PATH, 'views')
    set :assets, File.join(AIRSTRIP_PATH, 'front') 
    set :sessions, true
    
    # Extensions and custom conditions.
    extend Support::EnvCondition
    extend Support::JsonParamsCondition

    # Use asset pipeline.
    use Support::AssetPipeline, '/assets'

    # Extra helpers.
    helpers AuthHelpers
    
    get "/test", :only_env => ['development', 'test'] do
      erb :test_suite, :layout => false
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

    get "/admin" do
      if logged_in?
        erb :dashboard
      else
        status 401
        erb :login
      end
    end

    post "/admin/session", :provides => 'json' do
      content_type "application/json"

      # Passing if already logged in.
      status 204 and return if logged_in?

      login_f = AdminLoginForm.new(*params.values_at(:login, :password))
      login_f.on_error { status 400 }
      login_f.call { |login| authenticate!(login) and redirect to("/") }.to_json
    end

    get "/admin/logout" do
      log_out!
      redirect to("/")
    end

    before "/admin/api/*" do
      content_type "application/json"

      unless logged_in?
        status 401
        halt({ :error => "Unauthorized" }.to_json)
      end
    end

    get "/admin/api/signups", :provides => 'json' do
      signups_p = LatestSignupsPresenter.new(params[:page])
      signups_p.call.to_json
    end

    get "/admin/api/locations", :provides => 'json' do
      
    end

    get "/admin/api/referrers", :provides => 'json' do
      
    end
  end
end
