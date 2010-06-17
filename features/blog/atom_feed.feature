Feature: Atom feed
In order to be able too see updates to this blog
A reader will need an atom feed to subscribe to

Background:
Given the following posts:
| title          | slug           | body                   | published | published_on |
| My first blog  | my-first-blog  | This is my first blog  | true      | 12-Feb-1990  |
| My second blog | my-second-blog | This is my second blog | true      | 14-Feb-1990  |
| New blog post  | new-blog-post  | This post is not fin.. | false     | 15-Mar-2010  |

Scenario: Blog has a subscribe link
  Given I am on the blog page
  Then I should see a link to "http://feeds.feedburner.com/trevorpower"

Scenario: Feed contains all published posts
  Given am on the blog page as atom
  Then I should see "My first blog"
  And I should see "This is my first blog"
  And I should see "My second blog"
  And I should see "This is my second blog"
  And I should not see "New blog post"

Scenario: Author is "Trevor Power"
  Given am on the blog page as atom
  Then I should see "Trevor Power" within "author"    
