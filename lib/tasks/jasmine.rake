namespace :spec do
  desc "Runs jasmine specs"
  task :jasmine do
    require File.expand_path('../../../spec/jasmine', __FILE__)
  end
end
