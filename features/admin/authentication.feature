Feature: Authentication
  In order to prevent people from modifying the content of the site
  The author will need to login before accessing any admin page or feature
  
Background:
  Given that the administrator password is "admin"

Scenario Outline: Guests are redirected to login page
  When I go to <an admin page>
  Then I should be on the login page
  Examples:
  | an admin page     |
  | the posts page    |
  | the comments page |
  | the images page   |


Scenario Outline: Author can access admin pages once logged in
  Given I am on the login page
  When I fill in "password" with "admin"
  And press "Login" 
  And I go to <an admin page>
  Then I should be on <an admin page>
  Examples:
  | an admin page     |
  | the posts page    |
  | the comments page |
  | the images page   |

Scenario Outline: Once logged out the user cannot access the admin pages
  Given I am logged in with password "admin"
  When I follow "Log Out"
  And I go to <an admin page>
  Then I should be on the login page
  Examples:
  | an admin page     |
  | the posts page    |
  | the comments page |
  | the images page   |
  
Scenario Outline: Admin pages redirect to login page following an failed loggin attempt
  Given I am on the login page
  When I fill in "password" with "wrongpassword"
  And press "Login"
  And I go to <an admin page>
  Then I should be on the login page
  Examples:
  | an admin page     |
  | the posts page    |
  | the comments page |
  | the images page   |
