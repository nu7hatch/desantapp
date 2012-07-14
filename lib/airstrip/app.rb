require 'airstrip/helpers/auth_helpers'

module Airstrip
  class App < Sinatra::Application
    set :root, AIRSTRIP_PATH
    set :public_folder, File.join(AIRSTRIP_PATH, 'front/static')
    set :views, File.join(AIRSTRIP_PATH, 'views')
    set :assets, File.join(AIRSTRIP_PATH, 'front') 
    set :sessions, true

    # Use asset pipeline.
    use Support::AssetPipeline, '/assets'

    helpers AuthHelpers

    post "/signup.json" do
      content_type "application/json"

      signup_s = SignupService.new(self)
      signup_s.on_error { status 400 }
      signup_s.call.to_json
    end

    get "/" do
      erb :index
    end

    get "/admin" do
      if logged_in?
        redirect to("/admin/dashboard")
      else
        erb :login
      end
    end

    post "/admin/session.json" do
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

    get "/admin/dashboard" do
      erb :dashboard
    end

    get "/admin/signups.json" do
      content_type "application/json"

      signups_p = LatestSignupsPresenter.new(params[:page])
      signups_p.call.to_json
    end

    get "/admin/locations.json" do
      
    end

    get "/admin/referrers.json" do
      
    end
  end
end
