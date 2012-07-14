require 'sprockets'

module Support
  # Internal: Asset pipeline serves all dynamically generated asssets
  # through sprockets pipeline.
  class AssetPipeline
    # List of default asset paths.
    DEFAULT_ASSET_PATHS = %w(app lib)

    # Public: Constructor. Initializes sprockets environment.
    def initialize(app, prefix)
      @app = app
      @prefix = prefix
      @sprockets = Sprockets::Environment.new
      
      append_default_paths!
    end

    # Public: Registers given load paths in sprockets' env.
    #
    # dir - The Array of dirs to register
    #
    def append_paths(dirs = [])
      dirs.each { |dir| @sprockets.append_path(dir) }
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
