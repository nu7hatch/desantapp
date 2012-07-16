require 'sprockets'
require 'sinatra'
require 'json'
require 'active_record'
require 'active_model'
require 'active_support/all'
require 'active_model/validations'

require 'core_ext/hash'
require 'validators/email_validator'
require 'validators/admin_credentials_validator'

require 'reusable/callbacks'
require 'reusable/asset_pipeline'
require 'reusable/conditions/env_condition'
require 'reusable/conditions/json_params_condition'
require 'reusable/actions/test_action'
require 'reusable/apps_foundation'
require 'reusable/application'

require 'airstrip/version'

module Airstrip
  extend Reusable::AppsFoundation
end
