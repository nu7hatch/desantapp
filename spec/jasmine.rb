require File.expand_path('../spec_helper', __FILE__)
require 'rspec/jasmine'

app, _ = Rack::Builder.parse_file(File.join(ROOT_PATH, 'config.ru'))
selected_suites = ENV['SUITES'].split(':') if !!ENV['SUITES']

RSpec::Jasmine::SpecRunner.run(self,
  :app    => app,
  :port   => 5001,
  :suites => selected_suites || %w{/tests /admin/tests}
)
