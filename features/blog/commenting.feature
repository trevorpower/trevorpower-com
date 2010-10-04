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

  Scenario: See name of user with comments on the current post
    Given I have a post with title "Interesting fact" and the comments:
    | body                            | name      | email            |
    | What a great article!           | Mr. Smith | john.smith@it.it |
    And I am on the "Interesting fact" post  
    Then I should see "What a great article!"
    Then I should see "Mr. Smith"
    
  Scenario: See date of comment on the current post
    Given I have a post with title "Interesting fact" and the comments:
    | body                            | name      | email            | published_on |
    | What a great article!           | Mr. Smith | john.smith@it.it | 12-Jan-2006  |
    And I am on the "Interesting fact" post  
    Then I should see "What a great article!"
    Then I should see "12 January 2006"

  Scenario: Have link to users url with comments on the current post
    Given I have a post with title "Interesting fact" and the comments:
    | body                            | name       | email            | url     		|
    | What a great article!           | Mr. Smith  | john.smith@it.it | http://blog.me.me 	|
    | What a another great article!   | Mrs. Smith | mary.smith@it.it | http://blog.this.me 	|
    And I am on the "Interesting fact" post  
    Then I should see "What a great article!"
    Then I should see a link to "http://blog.me.me/"
    Then I should see a link to "http://blog.this.me/"

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

  Scenario: User is told that the url must contain "http://"
    Given I have a post with title "Another interesting fact"
    And I am on the "Another interesting fact" post
    When I fill in "Body" with "Wow, that is correct!"
    And I fill in "Name" with "Mr. T"
    And I fill in "Email" with "mr.t@gmail.com"
    And I fill in "Url" with "gmail.com"
    And press "Add Comment"
    Then I should be on the "Another interesting fact" post
    And should see "The URL is invalid, it must start with 'http://'"
