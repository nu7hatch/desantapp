module Airstrip
  class App < Sinatra::Application
    set :public_folder, File.join(AIRSTRIP_PATH, 'public')
    set :views, File.join(AIRSTRIP_PATH, 'views')
    enable :sessions

    helpers do
      # Public: Returns true when admin is logged in. 
      def logged_in?
        !!session[:logged_in]
      end

      # Public: Returns admin's name if logged in.
      def logged_as
        session[:logged_in].to_s
      end
    end

    post "/signup.json" do
      content_type "application/json"
      SignupService.call(self).to_json
    end

    get "/" do
      erb :index
    end

    get "/admin" do
      if signed_in?
        redirect_to "/admin/dashboard"
      else
        erb :login
      end
    end

    post "/admin/session" do
      return if logged_in?

      login_form = AdminLoginForm.new(*params.values_at(:login, :password))
      login_form.call { |login| session[:logged_in] = login }.to_json
    end

    get "/admin/logout" do
      session[:logged_in] = false
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
