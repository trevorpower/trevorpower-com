Feature: Comment moderation
  In order to remove spam or inappropriate content
  The administrator will need view and moderate all comments
  
  Scenario: View all comments
    Given I have a post with title "My first post" and the comments:
    | body |
    | "What a great first blog entry" |
    | "Keep up the good work" |
    And I have a post with title "Another post" and the comments:
    | body |
    | "Another good article" |
    And I am on the comments page
    Then I should see "What a great first blog entry"
    And I should see "Keep up the good work"
    And I should see "Another good article"



