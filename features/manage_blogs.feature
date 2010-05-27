Feature: Blog
  In order to be usefull as a blog
  Readers will need to see all my blog entries
  
Background:
Given the following posts:
| title         | slug          | content                | published | published_on |
| My first blog | my-first-blog | This is my first blog  | true      | 12-Feb-1990  |
| New blog post | new-blog-post | This post is not fin.. | false     | 19-Jan-2010  |
And I am on the blog page



Scenario: Posts are visible
  Then I should see "My first blog"
  Then I should see "New blog post"

Scenario: Title links to post
  When I follow "My first blog"
  Then I should see "My first blog" within "h1"
  




  
  


