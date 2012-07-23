require 'reusable/active_record_tasks'

namespace :db do
  task :paths do
    $db_dir = File.join(ROOT_PATH, 'db')
    $migrations_dir = File.join($db_dir, 'migrate')
  end

  task :get_db_name do
    $db_name = ENV['DATABASE_NAME'] || ENV['DATABASE']

    if $db_name.to_s.empty?
      puts "Invalid database name!"
      exit(1)
    end
  end

  task :raw_connection do
    require 'active_record'

    ActiveRecord::Base.establish_connection({ 
      :adapter  => ENV['DATABASE_ADAPTER'],
      :host     => ENV['DATABASE_HOST'],
      :username => ENV['DATABASE_USER'],
      :password => ENV['DATABASE_PASS']
    })
  end

  desc "Create project databases"
  task :create => [:raw_connection, :get_db_name] do
    options = {:charset => 'utf8', :collation => 'utf8_unicode_ci'}

    ['', '_test', '_development'].each do |suffix|
      begin
        ActiveRecord::Base.connection.create_database $db_name + suffix, options
      rescue => e
        raise e unless e.to_s =~ /database exists/
      end
    end
  end

  desc "Drop project databases"
  task :drop => [:raw_connection, :get_db_name] do
    ['', '_test', '_development'].each do |suffix|
      ActiveRecord::Base.connection.drop_database($db_name + suffix)
    end
  end

  desc "Truncate whole the database"
  task :truncate => [:environment, :paths] do
    Reusable::ActiveRecordTasks.truncate
  end

  desc "Delete all tables and reload schema"
  task :reset => [:environment, :paths] do
    Reusable::ActiveRecordTasks.reset
      Rake::Task["db:schema:load"].invoke
  end

  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate => [:environment, :paths] do
    version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    Reusable::ActiveRecordTasks.migrate($migrations_dir, version)
    Rake::Task["db:schema:dump"].invoke
  end

  namespace :migrate do
    desc 'Resets database - cleans it up and re-runs migrations'
    task :reset => [:environment, :paths] do
      Reusable::ActiveRecordTasks.migrate_reset($migrations_dir)
    end
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => [:environment, :paths] do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    Reusable::ActiveRecordTasks.rollback($migrations_dir, step)
    Rake::Task["db:schema:dump"].invoke
  end

  namespace :schema do
    desc "Create a db/schema.rb file that can be portably used against any DB supported by AR"
    task :dump => [:environment, :paths] do
      file = ENV['SCHEMA'] || File.join($db_dir, 'schema.rb')
      Reusable::ActiveRecordTasks.schema_dump(file)
    end

    desc "Load a ar_schema.rb file into the database"
    task :load => :environment do
      file = ENV['SCHEMA'] || File.join($db_dir, 'schema.rb')
      Reusable::ActiveRecordTasks.schema_load(file)
    end
  end
end
