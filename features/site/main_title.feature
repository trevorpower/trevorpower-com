Feature: Main Title
  In order to improve SEO and help readers know what they are looking at
  The reader or search engine spider will need the name the page
  and the author's name in the title of all pages

Background:
Given I have a post with title "Why I really like Ruby"
  
Scenario Outline: Pages contain name and author in the title
Given I am on the <Page>
Then I should see "<Full Title>" within "title"
Examples:
  | Page                          | Full Title                            |
  | home page                     | Home - Trevor Power                   |
  | about page                    | About - Trevor Power                  |
  | contact page                  | Contact - Trevor Power                |
  | blog page                     | Blog - Trevor Power                   |
  | "Why I really like Ruby" post | Why I really like Ruby - Trevor Power |
  | blog page as atom             | Trevor Power's blog                   |

Scenario Outline: Visiting a page shows the correct area selected in the navigation bar
Given I am on the <Page>
Then I should see "<Area>" within the selected navigation tab
Examples:
  | Page                              | Area    |
  | home page                         | Home	|
  | about page                        | About   |
  | contact page                      | Contact |
  | blog page                         | Blog    |
  | "Why I really like Ruby" post     | Blog	|

  
  
