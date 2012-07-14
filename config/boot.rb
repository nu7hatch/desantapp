require 'bundler'
Bundler.setup

RACK_ENV = ENV["RACK_ENV"] || 'development'

%w(database kaminari).each do |conf|
  require File.expand_path("../#{conf}", __FILE__)
end
