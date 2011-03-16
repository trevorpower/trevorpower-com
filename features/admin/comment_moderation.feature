Feature: Comment moderation
  In order to remove spam or inappropriate content
  The administrator will need view and moderate all comments
  
  Background:
    Given that the administrator password is "commentadmin"
    And I am logged in with password "commentadmin"

  Scenario: View comments from all posts
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| Mr. Smith | john.smith@it.it |
    And I have a post with title "Another post" and the comments:
    | body			| name      | email               |
    | Another good article   	| Garry     | g.moloney@gmail.com |
    When I go to the comments page
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"
    And I should see "Another good article"

  Scenario: View comment details
    Given I have a post with title "My first post" and the comments:
    | body   		    | name     | url 			| published_on | email 	     |
    | Keep up the good work | Joe Soap | http://joe.example.com	| 11-Jun-1999  | e@gmail.com | 
    When I go to the comments page
    Then I should see "Keep up the good work"
    And I should see "Joe Soap"
    And I should see "http://joe.example.com"
    And I should see "11-Jun-1999"
    And I should see "My first post"

  Scenario: Can hide a comment
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| Mr. Smith | john.smith@it.it |
    And I am on the comments page
    When I press "Hide" for comment whose body is "Want to buy cheap meds"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    But I should not see "Want to buy cheap meds"
    
  Scenario: Can show a comment
    Given I have a post with title "My first post" and the comments:
    | body 				| published | name      | email            |
    | What a great first blog entry 	| true      | spammer   | email@spam.org   |
    | Keep up the good work 		| true      | Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| false     | Mr. Smith | john.smith@it.it |
    When I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should not see "Want to buy cheap meds"

    When I go to the comments page
    And I press "Show" for comment whose body is "Want to buy cheap meds"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"

  Scenario: Delete a comment
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| Mr. Smith | john.smith@it.it |
    And I am on the comments page
    When I press "Destroy" for comment whose body is "Keep up the good work"
    Then I should see "What a great first blog entry"
    And I should not see "Keep up the good work"
    And I should see "Want to buy cheap meds"
