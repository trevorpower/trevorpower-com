Given /^I am logged in$/ do
  visit path_to("the login page")
  fill_in(:password, :with => "password1")
  click_button("Login")
end
