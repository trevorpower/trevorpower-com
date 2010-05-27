Feature: Blog
  In order to be usefull as a blog
  Readers will need to see all my blog entries
  
Background:
Given the following posts:
| title         | slug          | content                | published | published_on |
| My first blog | my-first-blog | This is my first blog  | true      | 12-Feb-1990  |
| New blog post | new-blog-post | This post is not fin.. | false     | 19-Jan-2010  |

Scenario: Posts are visible
  When I am on the blog page
  Then I should see "My first blog" within "h2"

  
  


