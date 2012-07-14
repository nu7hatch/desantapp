require 'bundler'
Bundler.setup

RACK_ENV = ENV["RACK_ENV"] || 'development'

require File.expand_path("../database", __FILE__)
