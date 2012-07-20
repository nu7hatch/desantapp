module Reusable
  # Public: Bunch of tasks to make work with ActiveRecord
  # easier, kinda more similar to Rails, though.
  module ActiveRecordTasks
    extend self

    def truncate
      conn = ActiveRecord::Base.connection
      tables = conn.execute("show tables").map { |r| r[0] }
      tables.delete "schema_migrations"
      tables.each { |t| conn.execute("TRUNCATE #{t}") }
    end

    def reset
      conn = ActiveRecord::Base.connection
      tables = conn.execute("show tables").map { |r| r[0] }
      tables.each { |t| conn.execute("DROP TABLE #{t}") }
    end

    def migrate_reset(dir, verbose = true)
      reset
      migrate(dir, nil, verbose)
    end

    def migrate(dir, version, verbose = true)
      self.verbose = verbose
      ActiveRecord::Migrator.migrate(dir, version)
    end

    def rollback(dir, step, verbose = true)
      self.verbose = verbose
      ActiveRecord::Migrator.rollback(dir, step)
    end

    def schema_dump(file)
      require 'active_record/schema_dumper'

      File.open(file, "w") do |f|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, f)
      end
    end
    
    def schema_load(file, verbose = true)
      $stdout = StringIO.new unless verbose
      load(file).tap { $stdout = STDOUT }
    end

    def test_prepare(schema, verbose = false)
      reset
      schema_load(schema, verbose)
    end

    def verbose=(verbose)
      ActiveRecord::Migration.verbose = verbose
    end
  end
end
