module Airstrip
  module Admin
    # Public: Admin login form service. Authenticates administrator
    # and gives access to the admin area.
    class LoginForm < Struct.new(:login, :password)
      include ActiveModel::Validations
      include Reusable::Callbacks

      validates :login,    :presence => true
      validates :password, :presence => true, :admin_credentials => true

      define_callback :on_error

      # Public: Default action. Executes given block if authentication
      # is successfull.
      #
      # Returns admin information or errors when something went wrong.
      def call(&block)
        if valid?
          yield login
          { :login => login }
        else
          run_callback :on_error
          { :error => errors.full_messages.to_sentence }
        end
      end
    end
  end
end
