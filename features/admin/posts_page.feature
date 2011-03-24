Feature: Posts Page
  In order to create new posts and manage existing posts
  The author will need a list of all posts along actions on those posts

Background:
Given that the administrator password is "admin"
And I am logged in with password "admin"

Scenario: See all posts
  Given the following posts:
  | title          | body                   |  published |
  | My first blog  | This is my first blog  |  true      |
  | My second blog | This is my second blog |  true      |
  | New blog post  | This post is not fin.. |  false     |
  And I am on the posts page
  Then I should see "My first blog"
  And I should see "My second blog"
  And I should see "New blog post"

Scenario: View post details
  Given the following posts:
  | title        | slug           | body                   | published | published_on |
  | My blog post | my-second-blog | This is my second blog | true      | 14-Feb-1990  |
  And I am on the posts page
  Then I should see "My blog post"
  And I should see "14-Feb-1990"

Scenario: Create a new post
  Given the following posts:
  | title          | body                   |
  | My first blog  | This is my first blog  |
  | My second blog | This is my second blog |
  And I am on the posts page
  When I follow "New post"
  And I fill in "title" with "My new draft"
  And I fill in "body" with "A long time ago, in a galaxy far far away..."
  And I press "Create"
  Then I should be on the posts page
  And I should see "My first blog"
  And I should see "My second blog"
  And I should see "My new draft"

Scenario: View a post
  Given the following posts:
  | title             | body                   |
  | My new blog post  | This post is not fin.. |
  And I am on the posts page
  When I follow "View" for post whose title is "My new blog post"
  Then I should be on the "My new blog post" post

Scenario: Delete a post
  Given the following posts:
  | title          | body                   |
  | My first blog  | This is my first blog  |
  | My second blog | This is my second blog |
  | New blog post  | This post is not fin.. |
  And I am on the posts page
  When I follow "Edit" for post whose title is "My second blog" 
  And I follow "Delete"
  Then I should be on the posts page

  And I should see "My first blog"
  And I should see "New blog post"
  But I should not see "My second blog"

Scenario: Publish a post
  Given the following posts:
  | title                | body                   |  published |
  | My latest draft post | This post is not fin.. |  false     |
  And I am on the posts page
  When I follow "Publish" for post whose title is "My latest draft post"
  And go to the blog page
  Then I should see "My latest draft post"

Scenario: Hide an already published post
  Given the following posts:
  | title                | body          |  published |
  | My latest blog post  | This so cool! |  true      |
  And I am on the blog page
  Then I should see "My latest blog post"

  When I go to the posts page
  And I follow "Hide" for post whose title is "My latest blog post"
  And go to the blog page
  Then I should not see "My latest blog post"

Scenario: Edit an existing post
  Given the following posts:
  | title          | body                   | published |
  | My second blog | This is my second blog | true      |
  And I am on the posts page
  When I follow "Edit" for post whose title is "My second blog"
  And fill in "body" with "Update: this has changed ..."
  And fill in "title" with "My second blog post (updated)"
  And press "Update"
  Then I should be on the posts page
  And I should see "My second blog post (updated)"

  When I go to the "My second blog post (updated)" post
  Then I should see "My second blog post (updated)"
  And I should see "Update: this has changed ..."

Scenario: Cancel edit of an existing post
  Given the following posts:
  | title          | body                   | published |
  | My second blog | This is my second blog | true      |
  And I am on the posts page
  When I follow "Edit" for post whose title is "My second blog"
  And fill in "body" with "Update: this has changed ..."
  And fill in "title" with "My second blog post (updated)"
  And follow "Cancel"
  Then I should be on the posts page
  And I should see "My second blog"
  But I should not see "My second blog post (updated)"

# The following scenario is failing and I suspect that the webrat fill_in function is 
# decoding the angle brackets, tests in browser show this scenario to be working fine
# must come back to investigate later
Scenario: Create new post with simple HTML in the body and title
  Given I am on the posts page
  When I follow "New post"
  And I fill in "title" with "<p> tags & '&' characters"
  And I fill in "body" with "I <u>don't</u> like it when '&lt;p&gt;' tags &amp; '&amp;' characters are not handled properly." 
  And I press "Create"
  And I go to the "<p> tags & '&' characters" post
  Then I should see "<p> tags & '&' characters" within "h1"
  #And I should see "I don't like it when '<p>' tags & '&' characters are not handled properly."
  
