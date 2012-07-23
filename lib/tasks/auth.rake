desc "Generates password hash for the passphrase specified in PASS=x"
task :password_hash do
  require 'bcrypt'
  puts BCrypt::Password.create(ENV["PASS"])
end
