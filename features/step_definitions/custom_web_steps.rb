Then /^The page source should not contain "(.*)"$/ do |text|
  response.body.should_not =~ /#{text}/m
end

