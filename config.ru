# -*- ruby -*-
require File.expand_path('../config/boot', __FILE__)
require 'airstrip'

map '/' do
  run Airstrip::App
end
