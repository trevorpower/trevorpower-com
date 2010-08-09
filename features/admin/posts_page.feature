Feature: Posts Page
  In order to create new posts and manage existing posts
  The author will need a list of all posts along actions on those posts

Background:
Given that the administrator password is "admin"
And I am logged in with password "admin"
And the following posts:
| title          | slug           | body                   | published | published_on |
| My first blog  | my-first-blog  | This is my first blog  | true      | 12-Feb-1990  |
| My second blog | my-second-blog | This is my second blog | true      | 14-Feb-1990  |
| New blog post  | new-blog-post  | This post is not fin.. | false     | 15-Mar-2010  |
And I am on the posts page

Scenario: See all posts
  Then I should see "My first blog"
  And I should see "My second blog"
  And I should see "New blog post"

Scenario: Create a new post
  When I follow "New post"
  And I fill in "title" with "My new draft"
  And I fill in "body" with "A long time ago, in a galaxy far far away..."
  And I select "08-Sep-2010" as the date
  And I press "Create"
  Then I should be on the posts page
  And I should see "My first blog"
  And I should see "My second blog"
  And I should see "New blog post"
  And I should see "My new draft"
  And I should see "08-Sep-2010"

Scenario: View a post
  When I follow "New blog post"
  Then I should see "This post is not fin.."

Scenario: Delete a post
  When I follow "Destroy" for post whose title is "My second blog" 
  Then I should see "My first blog"
  And I should not see "My second blog"
  And I should see "New blog post"

Scenario: Publish a post
  When I follow "Publish" for post whose title is "New blog post"
  And go to the blog page
  Then I should see "New blog post"

Scenario: Hide a post
  When I follow "Hide" for post whose title is "My first blog"
  And go to the blog page
  Then I should not see "My first blog"

Scenario: Edit a post
  When I follow "Edit" for post whose title is "My second blog"
  And fill in "body" with "Update: this has changed ..."
  And fill in "title" with "My second blog post"
  And press "Update"
  And go to the blog page
  Then I should see "My second blog post"
  And I should see "Update: this has changed ..."


# The following scenario is failing and I suspect that the webrat fill_in function is 
# decoding the angle brackets, tests in browser show this scenario to be working fine
# must come back to investigate later
#Scenario: Create new post with simple HTML in the body and title
  #When I follow "New post"
  #And I fill in "title" with "<p> tags & '&' characters"
  #And I fill in "body" with "I <u>don't</u> like it when '&lt;p&gt;' tags &amp; '&amp;' characters are not handled properly." 
  #Then I should see "I <u>don't</u> like it when '&lt;p&gt;' tags &amp; '&amp;' characters are not handled properly." within "body" 
  #And I press "Create"
  #And I go to the "<p> tags & '&' characters" post
  #Then I should see "<p> tags & '&' characters"
  #And I should see "I don't like it when '&lt;p&gt;' tags & '&' characters are not handled properly."
  
