require 'sprockets'

module Reusable
  # Internal: Asset pipeline serves all dynamically generated asssets
  # through sprockets pipeline.
  class AssetPipeline
    # List of default asset paths.
    DEFAULT_ASSET_PATHS = %w(app libs styles)

    # Public: Constructor. Initializes sprockets environment.
    def initialize(app, prefix, &block)
      @app = app
      @prefix = prefix
      @sprockets = Sprockets::Environment.new
      
      append_default_paths!
      instance_eval(&block) if block_given?
    end

    # Public: Registers given load paths in sprockets' env.
    #
    # dir - A Array of dirs to register
    #
    def append_paths(dirs = [])
      dirs.each { |dir| append_path(dir) }
    end

    # Public: Shorthand for sprockets append path. Appends single
    # directory to sprockets chain.
    #
    # dir - A String directory to be reigstered
    #
    def append_path(dir)
      @sprockets.append_path(dir)
    end

    # Public: Serves assets
    #
    # env - The Hash HTTP environment.
    #
    # Returns HTTP response data.
    def call(env)
      path_info = env["PATH_INFO"]
      
      if path_info =~ Regexp.new(@prefix)
        env["PATH_INFO"].sub!(@prefix, "")
        @sprockets.call(env)
      else
        @app.call(env)
      end
    ensure
      env["PATH_INFO"] = path_info
    end
    
    protected

    # Internal: Appends list of default asset paths to sprockets env.
    def append_default_paths!
      DEFAULT_ASSET_PATHS.map do |path| 
        @sprockets.append_path(File.join(@app.settings.assets, path))
      end
    end
  end
end
