# -*- ruby -*-
require "rspec/core/rake_task"

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "{.,apps/*}/spec/{,**/}*_spec.rb" 
end

desc "Generates password hash for the passphrase specified in PASS=x"
task :password_hash do
  require 'bcrypt'
  puts "Your password hash: %s" % BCrypt::Password.create(ENV["PASS"])
end

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => :environment do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback('db/migrate', step)
  end
end

desc "Opens console with loaded app env."
task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end

task :environment do
  require File.expand_path('../boot', __FILE__)
end
