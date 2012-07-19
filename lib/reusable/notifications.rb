require 'forwardable'

module Reusable
  # Public: Shorthand for delgating #instrument to 
  # ActiveSupport::Notifications.
  #
  # Usage
  #
  #   class Foo
  #     include Reusable::Notifications
  #
  #     def bar
  #       instrument 'bar', :foo => :bar
  #       return :bar
  #     end
  #
  module Notifications
    def self.included(base)
      base.extend Forwardable
      base.def_delegator ActiveSupport::Notifications, :instrument
    end
  end
end
