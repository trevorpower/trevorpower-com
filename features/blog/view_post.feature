Feature: View Post
  In order to read a post
  Visiters will need to be able to see the full content and title of a post
  
  Scenario: Title and content are visible
    Given I have a post with title "Post with HTML body" and body "<b>This is the body</b> with <em>HTML</em> including '&lt;b&gt;' tags"
    When I go to the "Post with HTML body" post
    Then I should see "Post with HTML body"
    And I should see "This is the body with HTML including '<b>' tags"


