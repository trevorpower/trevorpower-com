Feature: Blog
  In order to be usefull as a blog
  Readers will need to see all my blog entries
  
Background:
Given the following posts:
| title          | slug           | body                          | published | published_on |
| My first blog  | my-first-blog  | This is my <b>first</b> blog  | true      | 12-Feb-1990  |
| My second blog | my-second-blog | A post about &lt;div&gt; tags | true      | 14-Feb-1990  |
| New blog post  | new-blog-post  | This post is not fin..        | false     | 19-Jan-2010  |
And I have a post with title "Grumpy and complaining" and the comments:
| body                | name      | email            | published |
| What a load of crap | spammer   | email@spam.org   | false     |
| nice post	      | joe       | joe@example.org  | true      |
| you're right!       | soap      | soap@example.org | true      |

Scenario: View published posts
  Given I am on the blog page
  Then I should see "My first blog"
  And I should see "My second blog"
  And I should see "A post about <div> tags"
  And I should see "Grumpy and complaining"
  And I should see "2 comments" within post whose title is "Grumpy and complaining"

Scenario: View post details
  Given I am on the blog page
  Then I should see "My first blog"
  And I should see "This is my first blog"
  And I should see "12 February 1990"

Scenario: Draft posts are not visible in the blog
  Given I am on the blog page
  Then I should not see "New blog post"

Scenario: Title links to post
  Given I am on the blog page
  When I follow "My first blog"
  Then I should be on the "My first blog" post
