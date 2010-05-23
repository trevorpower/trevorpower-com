Feature: Main Title
  In order to improve SEO and help readers know what they are looking at
  The reader or search engine spider will need the name the page and the author's name in the title of all pages
  
Scenario Outline: Pages contain "Trevor Power" in the title
Given I am on the <page name> page
Then I should see "<full title>" within "title"
Examples:
| page name | full title             |
| home      | Home - Trevor Power    |
| about     | About - Trevor Power   |
| contact   | Contact - Trevor Power |


  
  
