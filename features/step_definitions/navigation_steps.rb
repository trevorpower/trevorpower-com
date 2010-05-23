Then /^I should see a link to "([^\"]*)"$/ do |url|
  pending #response.body.should have_xpath "//a[@href = '#{url}']"
end
