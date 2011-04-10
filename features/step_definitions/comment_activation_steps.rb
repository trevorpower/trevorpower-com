Given /^that commenting is active$/ do
  ENV['commenting_active'] = 'true' 
end

Given /^that commenting is not active$/ do
  ENV['commenting_active'] = nil 
end
