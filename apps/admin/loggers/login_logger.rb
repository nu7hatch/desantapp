module Desant
  module Admin
    # Internal: A logger bound to `.admin_login` notifications.
    class LoginLogger < ActiveSupport::LogSubscriber
      def failure(event)
        ip, login = event.payload.values_at(:ip, :login)
        
        # TODO: send an email notification...
        
        logger.error 'ADMIN_LOGIN.FAILURE'.bold.red + 
          " Invalid credentials, #{login}, #{ip.bold}".red
      end

      def success(event)
        ip_address = event.payload[:ip]
        
        logger.info 'ADMIN_LOGIN.SUCCESS'.bold.blue +
          " #{ip_address.bold}".blue
      end
    end
  end
end

Desant::Admin::LoginLogger.attach_to :admin_login
