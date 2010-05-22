Feature: Main title
  In order to know that they or on the home page for 
  The guest will need to see Trevor's name on the home 

  Scenario: Visit home page
    When I am on the home page
    Then I should see "Trevor Power"
    
  Scenario: Link to blog
    When I am on the home page
    Then I should see "Blog"

  Scenario: Link to about
    When I am on the home page
    Then I should see "About"
