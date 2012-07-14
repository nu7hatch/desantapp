require 'airstrip/helpers/auth_helpers'

module Airstrip
  class App < Sinatra::Application
    set :public_folder, File.join(AIRSTRIP_PATH, 'public')
    set :views, File.join(AIRSTRIP_PATH, 'views')
    enable :sessions

    helpers AuthHelpers

    post "/signup.json" do
      content_type "application/json"

      signup = SignupService.new(self)
      signup.on_error { status 400 }
      signup.call.to_json
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

      login = AdminLoginForm.new(*params.values_at(:login, :password))
      login.on_error { status 400 }
      login.call { |login| authenticate!(login) and redirect to("/") }.to_json
    end

    get "/admin/logout" do
      log_out!
      redirect to("/")
    end

    get "/admin/dashboard" do
      erb :dashboard
    end

    get "/admin/signups.json" do
    end

    get "/admin/locations.json" do
    end

    get "/admin/referrers.json" do
    end
  end
end
