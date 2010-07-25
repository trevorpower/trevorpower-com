Feature: Administration navigation
  In order to perform administrative tasks
  The administrator shall require cinsistant navigation around the important pages

Background:
  Given that the administrator password is "admin"
  And I am logged in with password "admin"

  Scenario Outline: Navigate to the images page
    Given I am on the <Admin Page>
    When I follow "Images"
    Then I should be on the images page
    Examples:
    | Admin Page      |
    | posts page      |
    | comments page   |

  Scenario Outline: Navigate to the posts page
    Given I am on the <Admin Page>
    When I follow "Posts"
    Then I should be on the posts page
    Examples:
    | Admin Page    |
    | images page   |
    | comments page |
