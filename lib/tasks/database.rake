migrations_dir = File.expand_path('../../../db/migrate', __FILE__)

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate(migrations_dir, ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => :environment do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback(migrations_dir, step)
  end

  desc 'Resets database - cleans it up and re-runs migrations'
  task :reset => :environment do
    ActiveRecord::Migrator.migrate(migrations_dir, 0)
    ActiveRecord::Migrator.migrate(migrations_dir, nil)
  end
end
