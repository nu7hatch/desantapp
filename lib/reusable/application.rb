module Reusable
  class Application < Sinatra::Application
    set(:public_folder) { File.join(root, 'assets/static') }
    set(:views) { File.join(root, 'views') }
    set(:assets) { File.join(root, 'assets') }
    set :sessions, true
  end
end
