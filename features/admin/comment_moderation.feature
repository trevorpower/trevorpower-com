Feature: Comment moderation
  In order to remove spam or inappropriate content
  The administrator will need view and moderate all comments
  
  Background:
    Given that the administrator password is "commentadmin"
    And I am logged in with password "commentadmin"
    And I have a post with title "My first post" and the comments:
    | body 				| name 		| url 				| published |
    | What a great first blog entry 	| Trevor 	| http://blog.trevorpower.com 	| true      |
    | Keep up the good work 		| Joe Soap 	| http://joe.example.com 	| true      |
    | Want to buy cheap meds		| John Doe 	| http://john.example.com 	| false     |
    And I have a post with title "Another post" and the comments:
    | body |
    | Another good article   |

  Scenario: View all comments
    Given I am on the comments page
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Joe Soap"
    And I should see "http://joe.example.com"
    And I should see "Another good article"
    And I should see "Want to buy cheap meds"

  Scenario: Can hide a comment
    Given I am on the comments page
    When I follow "Hide" for comment whose body is "Keep up the good work"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should not see "Keep up the good work"
    
  Scenario: Can show a comment
    Given I am on the comments page
    When I follow "Show" for comment whose body is "Want to buy cheap meds"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"

  Scenario: Delete a comment
    Given I am on the comments page
    When I follow "Destroy" for comment whose body is "Keep up the good work"
    Then I should see "What a great first blog entry"
    And I should not see "Keep up the good work"
    And I should not see "Joe Soap"
    And I should not see "http://joe.example.com"
    And I should see "Another good article"
    And I should see "Want to buy cheap meds"
