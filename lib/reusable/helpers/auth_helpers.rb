module Reusable
  # Public: Collection of authentication helpers. Should be included
  # and provided by the application.
  module AuthHelpers
    # Public: Returns true when admin is logged in. 
    def logged_in?
      !!session[:logged_in]
    end

    # Public: Returns admin's name if logged in.
    def current_user
      session[:logged_in].to_s if logged_in?
    end

    # Public: Sets current user.
    #
    # user - A String user name to be set.
    #
    def authenticate!(user)
      session[:logged_in] = user
    end

    # Public: Destroys current session.
    def log_out!
      session.delete(:logged_in)
    end
  end
end
