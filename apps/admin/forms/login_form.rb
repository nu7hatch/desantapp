require 'digest/sha1'

module Desant
  module Admin
    # Public: Admin login form service. Authenticates administrator
    # and gives access to the admin area.
    class LoginForm < Struct.new(:login, :password, :ip)
      include ActiveModel::Validations
      include Reusable::Callbacks
      include Reusable::Notifications

      validates :password, :admin_credentials => true

      define_callback :on_error

      # Public: Default action. Executes given block if authentication
      # is successfull.
      #
      # Returns admin information or errors when something went wrong.
      def call(&block)
        if valid?
          instrument 'success.admin_login', :login => login, :ip => ip
          token = generate_access_token
          yield login, token
          { :login => login, :access_token => token }
        else
          instrument 'failure.admin_login', :login => login, :ip => ip
          run_callback :on_error
          { :error => errors.full_messages.to_sentence }
        end
      end

      # Internal: Generates new access token.
      def generate_access_token
        Digest::SHA1.hexdigest(Time.now.to_s + rand(100000).to_s)
      end
    end
  end
end
