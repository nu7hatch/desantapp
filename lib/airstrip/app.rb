module Airstrip
  class App < Sinatra::Application
    set :public_folder, File.join(AIRSTRIP_PATH, 'public')
    set :views, File.join(AIRSTRIP_PATH, 'views')
    enable :sessions

    post "/signup.json" do
      content_type "application/json"
      SignupService.call(self).to_json
    end

    get "/" do
      erb :index
    end

    get "/admin" do
      if signed_in?
        redirect_to "/admin/signups"
      else
        erb :login
      end
    end

    get "/admin/signups" do
      erb :signups_list
    end

    post "/admin/session" do

    end
  end
end
