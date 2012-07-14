ENV['RACK_ENV'] = 'test'

require File.expand_path("../../config/boot", __FILE__)

require 'rspec'
require 'mocha'
require 'airstrip'

migrations = File.expand_path('../../db/migrate', __FILE__)
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate(migrations, 0)
ActiveRecord::Migrator.migrate(migrations, nil)

RSpec.configure do |conf|
  conf.mock_with :mocha
end
