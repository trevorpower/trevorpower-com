Then /^I should see a link to "([^\"]*)"$/ do |url|
  response.body.should have_xpath "//a[@href = '#{url}']"
end
