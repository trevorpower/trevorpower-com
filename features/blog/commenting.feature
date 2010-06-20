Feature: Commenting
  In order to provide feedback and provide additional information about the topic of a post
  Readers will need to be able to add comments to a post

  Scenario: See comments for the current post
    Given I have a post with title "Interesting fact" and the comments:
    | body                            |
    | Yes that is an interesting fact |
    | Very good point!                |
    | What a great article!           |
    And I have a post with title "Grumpy and complaining" and the comments:
    | body                |
    | What a load of crap |
    And I am on the "Interesting fact" post  
    Then I should see "Yes that is an interesting fact"
    And I should see "Very good point!"
    And I should see "What a great article!"
    And I should not see "What a load of crap"

  Scenario: Add new comment
    Given I have a post with title "Another interesting fact"
    And I am on the "Another interesting fact" post
    When I fill in "Body" with "Wow, that is correct!"
    And press "Add Comment"
    Then I should be on the "Another interesting fact" post
    And should see "Wow, that is correct!"
    
  Scenario: Comment contains angle brackets
    Given I have a post with title "Another interesting fact" and the comments:
    | body                                              |
    | This is the correct HTML to use, <h1>Heading</h1> |
    And I am on the "Another interesting fact" post
    Then I should see "This is the correct HTML to use, <h1>Heading</h1>"


