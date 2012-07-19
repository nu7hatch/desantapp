module Reusable
  # Public: Apps foundation is a base module for the project
  # namespace. Extended to the project module provides list of apps
  # and handy loader.
  #
  # Usage
  #
  #   module MyProject
  #     extend Reusable::AppsFoundation
  #   end
  #
  #   MyProject.apps += %(core admin)
  #   MyProject.load_apps "path/to/apps"
  #
  module AppsFoundation
    attr_accessor :apps

    # Public: Returns an Array list of configured app names. 
    def apps
      @apps ||= []
    end

    # Public: Loads apps from given root directory.
    #
    # from - A String name of the apps root directory.
    #
    # Returns list of loaded apps.
    def load_apps(from)
      apps.each do |app|
        require File.join(from, app, 'app.rb')
      end
    end
  end
end
