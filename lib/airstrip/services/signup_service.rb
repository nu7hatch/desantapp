module Airstrip
  class SignupService
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
