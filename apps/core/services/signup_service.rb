module Airstrip
  # Public: Signup service registers new email address signed up
  # from the landing page.
  class SignupService < Struct.new(:app)
    include Reusable::Callbacks
    extend Forwardable

    def_delegator ActiveSupport::Notifications, :instrument

    define_callback :on_error
    
    # Internal: mass assignment protection.
    def allowed_attributes
      %w(email)
    end

    # Public: Default operation, creates new signup entry.
    # 
    # Returns attributes of the created record or errors when something
    # went wrong.
    def call
      signup_attrs = (app.params[:signup] || {}).pick(*allowed_attributes)
      signup = Signup.new(signup_attrs)
      signup.set_client_info(app.request.ip, app.session[:referer])
        
      if signup.save
        instrument "success.signup", :signup => signup
        signup.attributes.pick('email')
      else
        instrument "error.signup", :signup => signup
        run_callback :on_error
        { :error => signup.errors.full_messages.to_sentence }
      end
    end
  end
end
