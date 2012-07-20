require 'active_record'
require 'logger'

if !!ENV['CLEARDB_DATABASE_URL']
  ActiveRecord::Base.establish_connection(ENV['CLEARDB_DATABASE_URL'])
else
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
end
