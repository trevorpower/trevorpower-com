Then /^The page source should not contain "(.*)"$/ do |text|
  page.body.should_not =~ /#{text}/m
end

