# -*- ruby -*-
require 'bundler/setup'
require 'sinatra'
require 'exoteric/api'

set :public_folder, File.expand_path('../public', __FILE__)
set :views, File.expand_path('../views', __FILE__)

get "/" do
  erb :index
end

map "/" do
  run Sinatra::Application
end

map "/social" do
  run Exoteric::API
end
