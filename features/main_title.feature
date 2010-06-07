Feature: Main Title
  In order to improve SEO and help readers know what they are looking at
  The reader or search engine spider will need the name the page
  and the author's name in the title of all pages

Background:
Given I have a post with title "Why I really like Ruby"
  
Scenario Outline: Pages contain name and author in the title
Given I am on <page>
Then I should see "<full title>" within "title"
Examples:
| page                              | full title                            |
| the home page                     | Home - Trevor Power                   |
| the about page                    | About - Trevor Power                  |
| the contact page                  | Contact - Trevor Power                |
| the blog page                     | Blog - Trevor Power                   |
| the "Why I really like Ruby" post | Why I really like Ruby - Trevor Power |
| the blog page as atom             | Trevor Power's blog                   |

Scenario Outline: Pages contain correct heading 1
Given I am on <page>
Then I should see "<heading>" within "h1"
Examples:
| page                              | heading                |
| the home page                     | Trevor Power           |
| the about page                    | About                  |
| the contact page                  | Contact                |
| the blog page                     | Blog                   |
| the "Why I really like Ruby" post | Why I really like Ruby |

  
  
