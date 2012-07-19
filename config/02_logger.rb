require 'logger'

# Disable stdout's buffering.
$stdout.sync = true

# NOTE: The $logger shouldn't be used directly in the application.
# You should use ActiveSupport::Notifications combined with
# ActiveSupport::LogSubscriber (which provides #logger) method.

if RACK_ENV == 'test'
  $logger = nil # No logger in testing...
else
  $logger = Logger.new(STDOUT)
end
