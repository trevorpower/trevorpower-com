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

Scenario Outline: Pages contain correct heading 1
Given I am on the <Page>
Then I should see "<Heading>" within "h1"
Examples:
  | Page                              | Heading                |
  | home page                         | Trevor Power           |
  | about page                        | About                  |
  | contact page                      | Contact                |
  | blog page                         | Blog                   |
  | "Why I really like Ruby" post     | Why I really like Ruby |

  
  