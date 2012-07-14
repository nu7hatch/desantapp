module Airstrip
  # Public: Admin login form service. Authenticates administrator
  # and gives access to the admin area.
  class AdminLoginForm < Struct.new(:login, :password)
    include ActiveModel::Validations

    validates :login,    :presence => true
    validates :password, :presence => true, :admin_credentials => true

    # Public: Default action. Executes given block if authentication
    # is successfull.
    #
    # Returns admin information or errors when something went wrong.
    def call(&block)
      if valid?
        yield login
        { :login => login }
      else
        errors
      end
    end
  end
end
