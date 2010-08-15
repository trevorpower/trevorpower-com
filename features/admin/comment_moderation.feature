Feature: Comment moderation
  In order to remove spam or inappropriate content
  The administrator will need view and moderate all comments
  
  Background:
    Given that the administrator password is "commentadmin"
    And I am logged in with password "commentadmin"

  Scenario: View all comments
    Given I have a post with title "My first post" and the comments:
    | body 				|
    | What a great first blog entry 	|
    | Keep up the good work 		|
    | Want to buy cheap meds		|
    And I have a post with title "Another post" and the comments:
    | body			|
    | Another good article   	|
    And I am on the comments page
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"
    And I should see "Another good article"

  Scenario: View comment details
    Given I have a post with title "My first post" and the comments:
    | body 				| name 		| url 				| published |
    | Keep up the good work 		| Joe Soap 	| http://joe.example.com 	| true      |
    And I am on the comments page
    And I should see "Keep up the good work"
    And I should see "Joe Soap"
    And I should see "http://joe.example.com"

  Scenario: Can hide a comment
    Given I have a post with title "My first post" and the comments:
    | body 				|
    | What a great first blog entry 	|
    | Keep up the good work 		|
    | Want to buy cheap meds		|
    And I am on the comments page
    When I follow "Hide" for comment whose body is "Want to buy cheap meds"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should not see "Want to buy cheap meds"
    
  Scenario: Can show a comment
    Given I have a post with title "My first post" and the comments:
    | body 				| published |
    | What a great first blog entry 	| true      |
    | Keep up the good work 		| true      |
    | Want to buy cheap meds		| false     |
    When I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should not see "Want to buy cheap meds"

    When I go to the comments page
    And I follow "Show" for comment whose body is "Want to buy cheap meds"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"

  Scenario: Delete a comment
    Given I have a post with title "My first post" and the comments:
    | body 				|
    | What a great first blog entry 	|
    | Keep up the good work 		|
    | Want to buy cheap meds		|
    And I am on the comments page
    When I follow "Destroy" for comment whose body is "Keep up the good work"
    Then I should see "What a great first blog entry"
    And I should not see "Keep up the good work"
    And I should see "Want to buy cheap meds"
