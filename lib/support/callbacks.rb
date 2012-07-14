module Support
  # Public: Callbacks provides very simple interface to define neat
  # callback methods, used mostly by form and service objects.
  #
  # Example:
  #
  #   class MyService
  #     include Support::Callbacks
  #     define_callback :on_error, :on_success
  #
  #     def call(condition)
  #       if condition
  #         run_callback :on_success
  #       else
  #         run_callback :on_error, "Something went wrong!"
  #       end
  #     end
  #   end
  #
  #   service = MyService.new
  #   service.on_error   { |msg| puts msg }
  #   service.on_success { puts "Ok!" }
  #   service.call
  #
  module Callbacks
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    # Public: Executes specified callbacks.
    #
    # name - A String name of the callbacks group to be executed.
    # args - An Array of extra arguments passed to the callback.
    #
    def run_callback(name, *args)
      callbacks[name].call(*args)
    end

    # Internal: Returns list of defined callbacks.
    def callbacks
      @callbacks ||= Mux.new
    end

    module ClassMethods
      # Public: Defines single custom callback method.
      #
      # name - A String name of the callback to be defined.
      #
      def define_callback(name)
        define_method(name) do |&block| 
          if block.respond_to?(:call)
            callbacks[name] << block
          else
            callbacks[name]
          end
        end
      end

      # Public: Defines custom callback methods for all listed names.
      #
      # names - An Array of callback names to be defined.
      #
      def define_callbacks(*names)
        names.each { |name| define_callback(name) }
      end
    end

    # Internal: Callbacks multiplexer.
    class Mux < Hash
      def [](name)
        super or self[name] = Callback.new        
      end
    end

    # Internal: Single callback method representation. Single callback
    # can contain many partials to be executed. 
    class Callback < Array
      def call(*args)
        each { |cb| cb.call(*args) }
      end
    end
  end
end
