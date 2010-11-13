Feature: Contact Owner
  In order to provide feadback, job offers and large sums of money 
  Visitors will need need to be able to send a message
  
Background:
  Given I am on the contact page
  
Scenario: Link to twitter
  Then I should see a link to "http://twitter.com/trevorpower"

Scenario: Send author a message
  When I fill in "name" with "Joe Blogs"
  And I fill in "email" with "joe.bloggs@example.com"
  And I fill in "subject" with "Hello"
  And I fill in "message" with "Hello, this is a very nice website."
  And I press "Send"
  Then 1 email should be delivered to email@trevorpower.com

