Feature: About
  In order to learn about the owner
  The guest will need to see information about the author
  
Background:
  Given I am on the about page

  Scenario: Title is "About"
    Then I should see "About - Trevor Power" within "title"
    
  Scenario: Navigate to Home page
    When I follow "Home"
    Then I should be on the home page

  Scenario: Navigate to Contact page
    When I follow "Contact"
    Then I should be on the contact page


