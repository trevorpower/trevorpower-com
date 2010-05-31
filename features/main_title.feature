Feature: Main Title
  In order to improve SEO and help readers know what they are looking at
  The reader or search engine spider will need the name the page
  and the author's name in the title of all pages
  
Given the following posts:
| title         | slug          | content                | published | published_on |
| My first blog | my-first-blog | This is my first blog  | true      | 12-Feb-1990  |
| New blog post | new-blog-post | This post is not fin.. | false     | 19-Jan-2010  |

Scenario Outline: Pages contain name and author in the title
Given I am on <page>
Then I should see "<full title>" within "title"
Examples:
| page                        | full title                   |
| the home page               | Home - Trevor Power          |
| the about page              | About - Trevor Power         |
| the contact page            | Contact - Trevor Power       |
| the blog page               | Blog - Trevor Power          |
| the "My first blog" post    | My first blog - Trevor Power |


  
  
