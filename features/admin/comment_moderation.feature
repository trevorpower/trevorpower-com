Feature: Comment moderation
  In order to remove spam or inappropriate content
  The administrator will need to view and moderate all comments
  
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

  Scenario: Can page a long list of comments
    Given I have a post with title "My post" and 25 comments

    When I go to the comments page
    Then I should see "My post - comment 25"
    And I should see "My post - comment 16"
    But I should not see "My post - comment 15"

    When I follow "Next"
    Then I should see "My post - comment 15"
    And I should see "My post - comment 6"
    But I should not see "My post - comment 16"
    And I should not see "My post - comment 5"

    When I follow "Next"
    Then I should see "My post - comment 5"
    And I should see "My post - comment 1"
    But I should not see "My post - comment 6"

    When I follow "Previous"
    Then I should see "My post - comment 15"
    And I should see "My post - comment 6"
    But I should not see "My post - comment 16"
    And I should not see "My post - comment 5"

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
    When I follow "Hide" for comment whose body is "Want to buy cheap meds"
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
    And I follow "Show" for comment whose body is "Want to buy cheap meds"
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
    When I follow "Destroy" for comment whose body is "Keep up the good work"
    Then I should see "What a great first blog entry"
    And I should not see "Keep up the good work"
    And I should see "Want to buy cheap meds"

  Scenario: Delete all comments with the same user name
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| Mr. Smith | john.smith@it.it |
    And I have a post with title "My second post" and the comments:
    | body 				| name      | email            |
    | What a great second blog entry 	| spammer   | spam@spam.org    |
    And I am on the comments page
    When I follow "Delete similar..." for comment whose body is "What a great first blog entry"

    Then I should see "What a great first blog entry"
    And I should see "spammer"

    When I check "2 - Name = spammer"
    And I press "Delete"
    Then I should be on the comments page

    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"

    But I should not see "What a great first blog entry"
    And I should not see "What a great second blog entry"

  Scenario: Delete all comments with the same email
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer1  | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| Mr. Smith | john.smith@it.it |
    And I have a post with title "My second post" and the comments:
    | body 				| name      | email            |
    | What a great second blog entry 	| spammer2  | email@spam.org    |
    And I am on the comments page 

    When I follow "Delete similar..." for comment whose body is "What a great first blog entry"
    Then I should see "email@spam.org"

    When I check "2 - Email = email@spam.org"
    And I press "Delete"
    Then I should be on the comments page

    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"

    But I should not see "What a great first blog entry"
    And I should not see "What a great second blog entry"

  Scenario: Delete all comments with the same url
    Given I have a post with title "My first post" and the comments:
    | body 			     | name      | email            | url            |
    | What a great first blog entry  | spammer1  | email@spam.org   | http://exa.com |
    | Keep up the good work 	     | Johnny    | johnny@corp.net  | http://test.co |
    | Want to buy cheap meds	     | Mr. Smith | john.smith@it.it | http://one.com |
    And I have a post with title "My second post" and the comments:
    | body 			     | name      | email            | url            |
    | What a great second blog entry | spammer2  | smap@spam.org    | http://exa.com |
    And I am on the comments page 

    When I follow "Delete similar..." for comment whose body is "What a great first blog entry"
    Then I should see "http://exa.com"

    When I check "2 - Url = http://exa.com"
    And I press "Delete"
    Then I should be on the comments page

    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"

    But I should not see "What a great first blog entry"
    And I should not see "What a great second blog entry"

  Scenario: Can cancel out of delete similar page
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    | Want to buy cheap meds		| Mr. Smith | john.smith@it.it |
    And I am on the comments page
    When I follow "Delete similar..." for comment whose body is "What a great first blog entry"
    And I follow "Cancel"
    Then I should be on the comments page
    And I should see "Keep up the good work"
    And I should see "Want to buy cheap meds"
    And I should see "What a great first blog entry"
