desc "Opens console with loaded app env."
task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end

task :environment do
  require File.expand_path('../../../boot', __FILE__)
end

task :puts do
  puts
end