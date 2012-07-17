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

    # Public: Returns current session token.
    def current_session_token
      session[:access_token]
    end

    # Public: Returns a hash with all the auth information.
    def auth_data
      {
        :login => current_user, 
        :access_token => current_session_token
      }
    end

    # Public: Sets current user.
    #
    # user - A String user name to be set.
    #
    def authenticate!(user, token)
      session[:logged_in]    = user
      session[:access_token] = token
    end

    # Public: Destroys current session.
    def log_out!
      session.delete(:logged_in)
    end
  end
end
