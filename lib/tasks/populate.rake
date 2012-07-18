desc "Populates dummy data to the database"
task :populate => :'db:reset' do
  require File.expand_path('../../../apps/core/spec/support/blueprints', __FILE__)

  include Populate

  populate_signups!
end

module Populate
  def populate_signups!
    puts "== Populating: Signup"

    30.times do
      Airstrip::Signup.make(:email => Faker::Internet.email).tap do |signup|
        signup.full_geocode
        signup.save!
        puts "  -> #<Airstrip::Signup email=#{signup.email.inspect} lat=#{signup.lat.inspect} lon=#{signup.lon.inspect} ip_address=#{signup.ip_address.inspect}>"
      end
    end

    puts
  end
end
