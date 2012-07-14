module Airstrip
  class AdminLoginForm < Struct.new(:login, :password)
    include ActiveModel::Validations

    validates :login,    :presence => true
    validates :password, :presence => true, :admin_credentials => true

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
