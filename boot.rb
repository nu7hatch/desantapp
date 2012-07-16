begin
  require 'bundler'
  Bundler.setup
rescue LoadError
  $stderr.write "Bundler not found. Run `gem install bundler` to install it.\n"
  exit(1)
end

ROOT_PATH = File.dirname(__FILE__)
APPS_PATH = File.join(ROOT_PATH, 'apps')

$LOAD_PATH.unshift(File.join(ROOT_PATH, 'lib'))
$LOAD_PATH.unshift(APPS_PATH)

RACK_ENV = ENV["RACK_ENV"] || 'development'

require 'airstrip'

# Load all the configuration files
Dir[File.expand_path('../config/*.rb', __FILE__)].each do |conf|
  require conf
end

# Load core and all the applications.
Airstrip.load_apps(APPS_PATH)
