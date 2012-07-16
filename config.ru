# -*- ruby -*-
require File.expand_path('../boot', __FILE__)

map '/' do
  run Airstrip::Core::App
end

map '/admin' do
  run Airstrip::Admin::App
end
