ENV['RACK_ENV'] = 'test'

require File.expand_path("../../config/boot", __FILE__)

require 'rspec'
require 'mocha'
require 'airstrip'

# Flush database and re-run migrations.
migrations = File.expand_path('../../db/migrate', __FILE__)
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate(migrations, 0)
ActiveRecord::Migrator.migrate(migrations, nil)

# Load extra spec helpers and support files.
Dir[File.expand_path("../spec_helpers/**/*.rb", __FILE__)].each do |helper| 
  require helper
end

# RSpec configuration.
RSpec.configure do |conf|
  conf.mock_with :mocha
end
