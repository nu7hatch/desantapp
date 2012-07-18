desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "{.,apps/*}/spec/{,**/}*_spec.rb" 
end
