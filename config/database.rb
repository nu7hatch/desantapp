require 'active_record'
require 'logger'

if RACK_ENV != 'production'
  ENV['DATABASE_NAME'] += "_#{RACK_ENV}"
end

ActiveRecord::Base.establish_connection({ 
  :adapter  => ENV['DATABASE_ADAPTER'],
  :database => ENV['DATABASE_NAME'],
  :host     => ENV['DATABASE_HOST'],
  :username => ENV['DATABASE_USER'],
  :password => ENV['DATABASE_PASS']
})

db_log_file = File.expand_path('../../log/database.log', __FILE__)
ActiveRecord::Base.logger = Logger.new(File.open(db_log_file, 'a'))
