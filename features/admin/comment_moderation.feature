Feature: Comment moderation
  In order to remove spam or inappropriate content
  The administrator will need view and moderate all comments
  
  Background:
    Given that the administrator password is "commentadmin"
    And I am logged in with password "commentadmin"
    And I have a post with title "My first post" and the comments:
    | body 				| name 		| url 				|
    | What a great first blog entry 	| Trevor 	| http://blog.trevorpower.com 	|
    | Keep up the good work 		| Joe Soap 	| http://joe.example.com 	|
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

  Scenario: Mark comment as spam
    Given I am on the comments page
    When I follow "Spam" for comment whose body is "Keep up the good work"
    And I go to the "My first post" post
    Then I should see "What a great first blog entry"
    And I should not see "Keep up the good work"
    
