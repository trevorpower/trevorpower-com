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

When /^I close "([^"]*)" to new comments$/ do |title|
  visit posts_path
  within("*[id=#{Post.find_by_title(title).dom_id}]") do
    click_link('Close to comments')
  end
end

Then /^I should not be able to comment on "([^"]*)"$/ do |title|
  visit blog_post_path(:slug => Post.find_by_title(title).slug)
  page.should have_no_content('Leave a Comment')  
  page.should have_no_content('Commenting has been deactivated')  
  page.should have_content('This post has been closed for commenting')  
end

Then /^I should be able to comment on "([^"]*)"$/ do |title|
  visit blog_post_path(:slug => Post.find_by_title(title).slug)
  page.should have_content('Leave a Comment')  
  page.should have_no_content('Commenting has been deactivated')  
  page.should have_no_content('This post has been closed for commenting')  
end

Given /^I have a closed post with title "([^"]*)"$/ do |title|
  Post.new(
    :title => title,
    :slug => Post.create_slug(title),
    :body => "body for this post (#{title})",
    :open_for_commenting => false
  ).save!
end

When /^I open "([^"]*)" to new comments$/ do |title|
  visit posts_path
  within("*[id=#{Post.find_by_title(title).dom_id}]") do
    click_link('Open to comments')
  end
end
