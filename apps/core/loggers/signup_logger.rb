require 'reusable/helpers/email_helpers'

module Desant
  # Internal: A logger bound to `*.signup` notifications.
  class SignupLogger < ActiveSupport::LogSubscriber
    include Reusable::EmailHelpers

    def error(event)
      signup = event.payload[:signup]
      
      logger.error 'SIGNUP.ERROR'.bold.yellow + 
        " #{signup.errors.full_messages.to_sentence}, #{signup.email.to_s.bold}".yellow
    end

    def success(event)
      signup = event.payload[:signup]
      anon_email = anonimize_email(signup.email.to_s)
      
      logger.info 'SIGNUP.SUCCESS'.bold.green + 
        " #{anon_email.bold}".green
    end
  end
end

Desant::SignupLogger.attach_to :signup
