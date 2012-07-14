module Airstrip
  # Public: Signup service registers new email address signed up
  # from the landing page.
  class SignupService < Struct.new(:app)
    include Support::Callbacks

    define_callback :on_error

    # Public: Default operation, creates new signup entry.
    # 
    # Returns attributes of the created record or errors when something
    # went wrong.
    def call
      signup = Signup.new(app.params[:signup])
      signup.set_client_info(app.request.ip, app.session[:referrer])
      signup.save!

      signup.attributes.pick('email')
    rescue => e # TODO: specify activerecord error
      run_callback :on_error
      signup.errors
    end
  end
end
