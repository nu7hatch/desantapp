module Reusable
  # Public: Extended, preconfigured Sinatra application class.
  #
  # Usage
  #
  #   class App < Reusable::Application
  #     set :root, File.dirname(__FILE__)
  #   end
  #
  # App will use ROOT/views, ROOT/assets and ROOT/assets/static
  # as views, assets and public folder respectively.
  class Application < Sinatra::Application
    set(:public_folder) { File.join(root, 'assets/static') }
    set(:views) { File.join(root, 'views') }
    set(:assets) { File.join(root, 'assets') }
    set :sessions, true
  end
end
