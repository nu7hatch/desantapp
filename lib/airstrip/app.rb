require 'airstrip/helpers/auth_helpers'

module Airstrip
  class App < Sinatra::Application
    set :public_folder, File.join(AIRSTRIP_PATH, 'public')
    set :views, File.join(AIRSTRIP_PATH, 'views')
    enable :sessions

    helpers AuthHelpers

    post "/signup.json" do
      content_type "application/json"
      SignupService.call(self).to_json
    end

    get "/" do
      erb :index
    end

    get "/admin" do
      if logged_in?
        redirect_to "/admin/dashboard"
      else
        erb :login
      end
    end

    post "/admin/session" do
      return if logged_in?

      login_form = AdminLoginForm.new(*params.values_at(:login, :password))
      login_form.call { |login| authenticate!(login) }.to_json
    end

    get "/admin/logout" do
      log_out!
    end

    get "/admin/dashboard" do
      erb :'admin/dashboard'
    end

    get "/admin/signups" do
    end

    get "/admin/locations" do
    end

    get "/admin/referrers" do
    end
  end
end
