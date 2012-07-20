require "rspec/core/rake_task"

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "{.,apps/*}/spec/{,**/}*_spec.rb" 
end

namespace :spec do
  desc "Run all test suites"
  task :all => [:spec, :puts, :'spec:jasmine']
end
