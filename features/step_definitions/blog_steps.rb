Given /^the following posts:$/ do |posts|
  Post.create(posts.hashes)
end

Given /^I have a post with title "([^\"]*)"$/ do |title|
  Post.new(:title => title, :slug => Post.create_slug(title), :body => "body for this post (#{title})").save!
end

Given /^I have a post with title "([^\"]*)" and body "([^\"]*)"$/ do |title, body|
  Post.new(:title => title, :body => body).save!
end

Given /^I have a post with title "([^\"]*)" and the comments:$/ do |title, comments|
  post = Post.new(
    :title => title,
    :slug => Post.create_slug(title),
    :body => "body for this post (#{title})",
    :published => true
  )
  post.save!
  comments.hashes.each do |hash| 
    comment = post.comments.build(hash)
    comment.save!
  end
  post.save!
end

Given /^I have a post with title "([^\"]*)" and (\d+) comments$/ do |title, count|
  post = Post.new(
    :title => title,
    :slug => Post.create_slug(title),
    :body => "body for this post (#{title})",
    :published => true
  )
  post.save!
  count.to_i.times do |i|
    comment = post.comments.build(
      :body => "#{title} - comment #{i+1}",
      :name => "commenter #{i+1}",
      :email => "test#{i}@example.com",
      :published_on => Time.new(2011, 01, 01) + i.days
    )
    comment.save!
  end
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

