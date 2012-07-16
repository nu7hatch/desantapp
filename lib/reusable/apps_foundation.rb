module Reusable
  module AppsFoundation
    attr_accessor :apps

    def apps
      @apps ||= []
    end

    def load_apps(from)
      apps.each do |app|
        require File.join(from, app, 'app.rb')
      end
    end
  end
end
