module Airstrip
  # Public: Signup service registers new email address signed up
  # from the landing page.
  class SignupService
    # Public: Default operation, creates new signup entry.
    # 
    # app - A Sinatra::Application instance.
    #
    # Returns attributes of the created record or errors when something
    # went wrong.
    def self.call(app)
      @signup = Signup.new(app.params[:signup])
      @signup.set_client_info(app.request.ip, app.session[:referrer])
      @signup.save!

      @signup.attributes.pick('email')
    rescue => e # TODO: specify activerecord error
      @signup.errors
    end
  end
end
