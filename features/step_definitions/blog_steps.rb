Given /^the following posts:$/ do |posts|
  Post.delete_all
  Post.create!(posts.hashes)
end

Given /^I have a post with title "([^\"]*)"$/ do |title|
  Post.create(:title => title)
end

When /^I delete the (\d+)(?:st|nd|rd|th) blog$/ do |pos|
  visit blogs_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following blogs:$/ do |expected_blogs_table|
  expected_blogs_table.diff!(tableish('table tr', 'td,th'))
end
