Feature: Posts Page
  In order to create new posts manage existing posts
  The author will need a list of all posts along

Background:
Given the following posts:
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
  And I press "Create"
  And I go to the posts page
  Then I should see "My first blog"
  And I should see "My second blog"
  And I should see "New blog post"
  And I should see "My new draft"

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
  And goto the blog page
  Then I should see "New blog post"

  
