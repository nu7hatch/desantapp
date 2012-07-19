require 'reusable/helpers/email_helpers'

module Airstrip
  class SignupLogger < ActiveSupport::LogSubscriber
    def error(event)
      signup = event.payload[:signup]

      logger.error color("SIGNUP #{signup.errors.full_messages.to_sentence}, #{signup.email.to_s.bold}", YELLOW)
    end

    def success(event)
      signup = event.payload[:signup]

      anon_email = EmailHelpers.anonimize_email(signup.email.to_s)
      logger.info color("SIGNUP Success, #{anon_email.bold}", GREEN)
    end

    private
    
    def escape_email(email)
    end
  end
end

Airstrip::SignupLogger.attach_to :signup
