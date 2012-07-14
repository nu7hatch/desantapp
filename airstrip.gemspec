# -*- ruby -*-
require 'rubygems'
require File.expand_path("../lib/airstrip/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "airstrip"
  s.version = Airstrip.version
  s.summary = "Sinatra application for landing pages"
  s.description = "Airstrip is an open source Sinatra application used for creating neat and simple landing pages"
  s.authors = ["Krzysztof Kowalik"]
  s.email = "chris@nu7hat.ch"
  s.homepage = "http://airstrip.github.com/"
  s.license = "MIT"

  s.files = Dir["{lib/**/*.rb,spec/**/*.rb,public/**/*,views/**/*,Rakefile,README.md,ChangeLog,*.gemspec}"]
  s.test_files = Dir["spec/**/*.rb"]
  s.require_paths = ["lib"]
  
  s.add_dependency "rake"
  s.add_dependency "mail"
  s.add_dependency "json"
  s.add_dependency "activesupport"
  s.add_dependency "activerecord"
  s.add_dependency "activemodel"
  s.add_dependency "sinatra"
  s.add_dependency "bcrypt-ruby"
  s.add_dependency "kaminari"
  s.add_dependency "padrino-helpers"
  s.add_dependency "machinist", "~> 2.0"
  s.add_dependency "ffaker"

  s.add_development_dependency "rspec", "~> 2.4"
  s.add_development_dependency "mocha", "0.11.4"
end
