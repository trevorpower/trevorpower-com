Feature: Commenting
  In order to provide feedback and provide additional information about the topic of a post
  Readers will need to be able to add comments to a post

  Scenario: See comments for the current post
    Given I have a post with title "Interesting fact" and the comments:
    | body                            | name      | email            |
    | Yes that is an interesting fact | spammer   | email@spam.org   |
    | Very good point!                | Johnny    | johnny@corp.net  |
    | What a great article!           | Mr. Smith | john.smith@it.it |
    And I have a post with title "Grumpy and complaining" and the comments:
    | body                | name      | email            |
    | What a load of crap | spammer   | email@spam.org   |
    And I am on the "Interesting fact" post  
    Then I should see "Yes that is an interesting fact"
    And I should see "Very good point!"
    And I should see "What a great article!"
    And I should not see "What a load of crap"

  Scenario: Add new comment
    Given I have a post with title "Another interesting fact"
    And I am on the "Another interesting fact" post
    When I fill in "Body" with "Wow, that is correct!"
    And I fill in "Name" with "Mr. T"
    And I fill in "Email" with "mr.t@gmail.com"
    And press "Add Comment"
    Then I should be on the "Another interesting fact" post
    And should see "Wow, that is correct!"
    
  Scenario: Comment contains angle brackets
    Given I have a post with title "Another interesting fact" and the comments:
    | body                                              | name      | email            |
    | This is the correct HTML to use, <h1>Heading</h1> | spammer   | email@spam.org   |
    And I am on the "Another interesting fact" post
    Then I should see "This is the correct HTML to use, <h1>Heading</h1>"


