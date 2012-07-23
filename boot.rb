begin
  require 'bundler'
  Bundler.setup
rescue LoadError
  $stderr.write "Bundler not found. Run `gem install bundler` to install it.\n"
  exit(1)
end

# Rack environment configuration.
RACK_ENV = ENV["RACK_ENV"] || 'development'

# Application paths.
ROOT_PATH = File.dirname(__FILE__)
APPS_PATH = File.join(ROOT_PATH, 'apps')

# Configure load path.
[ File.join(ROOT_PATH, 'lib'), APPS_PATH ].each do |path|
  $LOAD_PATH.unshift(path)
end

# The app foundation.
require 'desant'

# Load all the configuration files
Dir[File.expand_path('../config/*.rb', __FILE__)].each do |conf|
  require conf
end

# Load core and all the applications.
Desant.load_apps(APPS_PATH)
