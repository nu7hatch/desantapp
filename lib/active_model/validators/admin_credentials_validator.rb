require 'bcrypt'

# Public: Validator for local admin credentials. Valid credentials
# information should be stored in ADMIN_LOGIN and ADMIN_PASSWORD_HASH
# environment variables. To generate password hash use the following
# rake taks:
#
#   rake password_hash PASS=your_secret_password
#
class AdminCredentialsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_login?(record.login) && valid_password?(record.password)
      msg = I18n.t(:"validators.credentials.invalid", :default => "are invalid")
      record.errors[:credentials] << msg
    end
  end

  protected

  # Internal: Returns true when specified login is correct.
  def valid_login?(login)
    login == ENV['ADMIN_LOGIN']
  end
  
  # Internal: Returns true when specified password is correct.
  def valid_password?(password)
    BCrypt::Password.new(ENV['ADMIN_PASSWORD_HASH']).is_password?(password)
  end
end
