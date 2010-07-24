Given /^I am logged in with password "([^"]*)"$/ do |password|
  visit path_to("the login page")
  fill_in(:password, :with => password)
  click_button("Login")
end

Given /^that the administrator password is "([^"]*)"$/ do |password|
  ENV['ADMIN_PASSWORD'] = password 
end

