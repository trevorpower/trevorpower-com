Then /^The page source should not contain "(.*)"$/ do |text|
  assert_not_match /#{text}/m, page.body 
end

