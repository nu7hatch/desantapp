require "machinist/active_record"
require "ffaker"

Airstrip::Signup.blueprint do
  email      { "me#{sn}@fakemail.com" }
  ip_address { Faker::Internet.ip_v4_address }
  referer    { Faker::Internet.uri('http') }
end
