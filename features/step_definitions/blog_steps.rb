Given /^the following posts:$/ do |posts|
  Post.create!(posts.hashes)
end

Given /^I have a post with title "([^\"]*)"$/ do |title|
  Post.create(:title => title, :slug => Post.create_slug(title))
end

Given /^I have a post with title "([^\"]*)" and body "([^\"]*)"$/ do |title, body|
  Post.create(:title => title, :body => body)
end

Given /^I have a post with title "([^\"]*)" and the comments:$/ do |title, comments|
  post = Post.create(:title => title, :comments => comments.hashes, :slug => Post.create_slug(title))
  post.save
end

Given /^I have a post with title "([^\"]*)" and the images:$/ do |title, images|
  post = Post.create(:title => title, :images => images.hashes, :slug => Post.create_slug(title))
  post.save
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

Given /^the following images:$/ do |images|
  dir = "public/uploaded_images/#{Rails.env}/"
  images.hashes.each do |hash|
    File.open(dir + hash["name"], "w"){}
    S3Object.store(hash["name"], 'Hello world!',S3BucketName)
  end
end
