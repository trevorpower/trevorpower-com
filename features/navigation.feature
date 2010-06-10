Feature: Navigation
  In order to easily navigate the site
  The users will need to see a comment set of navigations link on all pages
  
Scenario: All pages have links to the main pages of the site
  Given I am on the home page
  When I follow "Contact"
  Then I should be on the contact page

  

