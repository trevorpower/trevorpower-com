Feature: Navigation
  In order to easily navigate the site
  The users will need to see a comment set of navigations link on all pages
 
Background:
Given I have a post with title "My holiday snaps"

  Scenario Outline: Navigate to the contact page
    Given I am on <Page>
    When I follow "Contact"
    Then I should be on the contact page
    Examples:
    | Page                        |
    | the home page               |
    | the about page              |
    | the blog page               |
    | the "My holiday snaps" post |
    
  Scenario Outline: Navigate to the about page
    Given I am on <Page>
    When I follow "About"
    Then I should be on the about page
    Examples:
    | Page                        |
    | the home page               |
    | the contact page            |
    | the blog page               |
    | the "My holiday snaps" post |
  
  Scenario Outline: Navigate to the blog page
    Given I am on <Page>
    When I follow "Blog"
    Then I should be on the blog page
    Examples:
    | Page                        |
    | the home page               |
    | the contact page            |
    | the about page              |
    | the "My holiday snaps" post |
    
  Scenario Outline: Navigate to the home page
    Given I am on <Page>
    When I follow "Blog"
    Then I should be on the blog page
    Examples:
    | Page                        |
    | the blog page               |
    | the contact page            |
    | the about page              |
    | the "My holiday snaps" post |
    
