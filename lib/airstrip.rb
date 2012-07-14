require 'sinatra'
require 'json'
require 'active_record'

unless defined?(AIRSTRIP_PATH)
  AIRSTRIP_PATH = File.expand_path("../../", __FILE__)
end

require 'core_ext/hash'
require 'active_model/validators/email_validator'

require 'airstrip/version'
require 'airstrip/models/signup'
require 'airstrip/services/signup_service'
require 'airstrip/app'

module Airstrip
end
