require 'sprockets'
require 'sinatra'
require 'json'
require 'require_all'

require 'active_support/all'
require 'active_support/notifications'
require 'active_support/log_subscriber'
require 'active_record'
require 'active_model'
require 'active_model/validations'

require 'core_ext/all'

require 'validators/email_validator'
require 'validators/admin_credentials_validator'

require 'reusable/notifications'
require 'reusable/callbacks'
require 'reusable/asset_pipeline'
require 'reusable/conditions/env_condition'
require 'reusable/conditions/simple_auth_condition'
require 'reusable/conditions/json_params_condition'
require 'reusable/actions/test_action'
require 'reusable/apps_foundation'
require 'reusable/application'

require 'desant/version'

module Desant
  extend Reusable::AppsFoundation
end
