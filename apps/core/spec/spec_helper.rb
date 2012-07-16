require File.join(ROOT_PATH, 'spec/spec_helper')

# Load extra spec helpers and support files.
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each do |helper| 
  require helper
end
