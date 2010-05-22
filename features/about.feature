Feature: About
  In order to learn about the owner
  The guest will need to see information about the author
  
  Scenario: Title is "About"
    When I am on the about page
    Then I should see "About - Trevor Power" within "title"

  Scenario: Links to Home page
    When I am on the about page
    Then I should see "Home" within "a"


