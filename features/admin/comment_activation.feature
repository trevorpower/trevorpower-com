Feature: Comment activiation
  In order to prevent spam or inappropriate content
  The administrator will need be able to activate and deactivate commenting

  Background:
    Given that the administrator password is "commentadmin"
    And I am logged in with password "commentadmin"

  Scenario: Deactivate commenting
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    And that commenting is active
    And I am on the comments page
    When I follow "Deactivate Commenting"
    And go to the "My first post" post
    Then I should not see "Add Comment"
    And I should not see "Leave a Comment"
    But I should see "Commenting has been deactivated, but you can still contact me directly."


  Scenario: Activate commenting
    Given I have a post with title "My first post" and the comments:
    | body 				| name      | email            |
    | What a great first blog entry 	| spammer   | email@spam.org   |
    | Keep up the good work 		| Johnny    | johnny@corp.net  |
    And that commenting is not active
    And I am on the comments page

    When I follow "Activate Commenting"
    Then I should be on the comments page

    When go to the "My first post" post
    Then I should not see "Commenting has been deactivated"
    But I should see "Leave a Comment"

  Scenario: Close a post for commenting
    Given I have a post with title "My first post"
    And I have a post with title "My second post"
    And that commenting is active

    When I close "My second post" to new comments

    Then I should be able to comment on "My first post"
    But I should not be able to comment on "My second post"

  Scenario: Open a post for commenting
    Given I have a closed post with title "My closed post"
    And I have a closed post with title "My second post"
    And that commenting is active

    When I open "My second post" to new comments

    Then I should not be able to comment on "My closed post"
    But I should be able to comment on "My second post"
