Feature: Navigation
  In order to easily navigate the site
  Readers will need to see a commen set of navigation link on all pages
 
Background:
Given I have a post with title "My holiday snaps"

  Scenario Outline: Navigate to the contact page
    Given I am on the <Page>
    When I follow "Contact"
    Then I should be on the contact page
    Examples:
    | Page                        |
    | home page                   |
    | about page                  |
    | blog page                   |
    | "My holiday snaps" post     |
    
  Scenario Outline: Navigate to the about page
    Given I am on the <Page>
    When I follow "About"
    Then I should be on the about page
    Examples:
    | Page                        |
    | home page                   |
    | contact page                |
    | blog page                   |
    | "My holiday snaps" post     |
  
  Scenario Outline: Navigate to the blog page
    Given I am on the <Page>
    When I follow "Blog"
    Then I should be on the blog page
    Examples:
    | Page                        |
    | home page                   |
    | contact page                |
    | about page                  |
    | "My holiday snaps" post     |
    
  Scenario Outline: Navigate to the home page
    Given I am on the <Page>
    When I follow "Blog"
    Then I should be on the blog page
    Examples:
    | Page                        |
    | blog page                   |
    | contact page                |
    | about page                  |
    | "My holiday snaps" post     |
    
