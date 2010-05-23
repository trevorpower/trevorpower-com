Feature: Contact Owner
  In order to provide feadback, job offers and large sums of money 
  Visiters will need need to be able to send a message
  
Background:
  Given I am on the contact page
  
Scenario: Title is Contact
  Then I should see "Contact - Trevor Power" within "title"

Scenario: Link to twitter
  Then I should see a link to "http://twitter.com/trevorpower"

Scenario: Send author a message
  When I fill in "name" with "Joe Blogs"
  And I fill in "address" with "joe.bloggs@example.com"
  And I fill in "body" with "Hello, this is a very nice website."
  And I press "Send Email"
  Then 1 email should be delivered to contact@trevorpower.com



