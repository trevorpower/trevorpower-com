Feature: Home Page
  In order to learn about the author and his activities 
  The reader will need to see lots of information about the author

Background:
Given I am on the home page

Scenario: Visit home page
  Then I should see "Trevor Power"
    
Scenario: Link to blog
  Then I should see "Blog"

Scenario: Link to about
  Then I should see "About"

Scenario: Link to contact
  Then I should see "Contact"
