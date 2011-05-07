require 'bcrypt'

desc "Set the admin password"
task :password, [:new_password] => :environment do |t, args|
  salt = BCrypt::Engine.generate_salt

  puts "\n" 
  puts "To set the password locally"
  puts "export ADMIN_PASSWORD_HASH='#{BCrypt::Engine.hash_secret(args.new_password, salt)}'"
  puts "export ADMIN_PASSWORD_SALT='#{salt}'"
 
  puts "\n"

  puts "To set the password on Heroku" 
  puts "heroku config:add ADMIN_PASSWORD_HASH='#{BCrypt::Engine.hash_secret(args.new_password, salt)}'"
  puts "heroku config:add ADMIN_PASSWORD_SALT='#{salt}'"
 
  puts "\n" 
end
