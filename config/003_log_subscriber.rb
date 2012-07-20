require 'active_support/log_subscriber'

# We must get rid of Rails.logger shit from LogSubscriber,
# otherwise it's not gonna work.

class ActiveSupport::LogSubscriber
  def logger
    @logger ||= $logger
  end
end
