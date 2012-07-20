ENV['RACK_ENV'] = 'test'

require File.expand_path("../../boot", __FILE__)

require 'rspec'
require 'mocha'
require 'airstrip'

# Flush database and re-run migrations.
require 'reusable/active_record_tasks'
Reusable::ActiveRecordTasks.test_prepare(File.join(ROOT_PATH, 'db/schema.rb'))

# Load extra spec helpers and support files.
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each do |helper| 
  require helper
end

# RSpec configuration.
RSpec.configure do |conf|
  conf.mock_with :mocha
end
