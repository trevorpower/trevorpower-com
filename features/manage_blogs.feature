Feature: Blog
  In order to be usefull as a blog
  Readers will need to see all my blog entries
  
Background:
Given the following posts:
| title          | slug           | content                 | published | published_on |
| My first blog  | my-first-blog  | This is my first blog   | true      | 12-Feb-1990  |
| My second blog | my-second-blog | This is my second blog  | true      | 14-Feb-1990  |
| New blog post  | new-blog-post  | This post is not fin..  | false     | 19-Jan-2010  |

Scenario: Published posts are visible in the blog
  Given I am on the blog page
  Then I should see "My first blog"
  Then I should see "My second blog"

Scenario: Draft posts are not visible in the blog
  Given I am on the blog page
  Then I should not see "New blog post"

Scenario: Title links to post
  Given I am on the blog page
  When I follow "My first blog"
  Then I should be on the "My first blog" post
  




  
  


