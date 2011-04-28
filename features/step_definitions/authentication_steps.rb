require 'bcrypt'

Given /^I am logged in with password "([^"]*)"$/ do |password|
  visit path_to("the login page")
  fill_in(:password, :with => password)
  click_button("Login")
end

Given /^that the administrator password is "([^"]*)"$/ do |password|
  salt = BCrypt::Engine.generate_salt
  ENV['ADMIN_PASSWORD_HASH'] = BCrypt::Engine.hash_secret(password, salt)
  ENV['ADMIN_PASSWORD_SALT'] = salt
end

