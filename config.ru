# -*- ruby -*-
require File.expand_path('../boot', __FILE__)

map '/' do
  run Desant::Core::App
end

map '/admin' do
  run Desant::Admin::App
end
