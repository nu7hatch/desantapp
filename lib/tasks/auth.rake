desc "Generates password hash for the passphrase specified in PASS=x"
task :password_hash do
  require 'bcrypt'
  puts "Your password hash: %s" % BCrypt::Password.create(ENV["PASS"])
end
