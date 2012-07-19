module Airstrip
  class SignupLogger < ActiveSupport::LogSubscriber
    def error(event)
      signup = event.payload[:signup]

      logger.error color("SIGNUP #{signup.errors.full_messages.to_sentence}, #{signup.email.to_s.bold}", YELLOW)
    end

    def success(event)
      signup = event.payload[:signup]

      escaped_email = escape_email(signup.email.to_s)
      logger.info color("SIGNUP Success, #{escaped_email.bold}", GREEN)
    end

    private
    
    def escape_email(email)
      name, domain = email.split('@')
      name = name.size > 3 ? name.to(2) + '...' : name.first + '...'
      return [ name, domain ].join('@')
    end
  end
end

Airstrip::SignupLogger.attach_to :signup
