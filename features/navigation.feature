Feature: Navigation
  In order to easily navigate the site
  The users will need to see a comment set of navigations link on all pages
 
  Scenario Outline: All pages have links to the contact page of the site
    Given I am on the home page
    When I follow <Link>
    Then I should be on <Page>
    Examples:
    | Link      | Page             |
    | "Contact" | the contact page |
    | "About"   | the about page   |
    | "Blog"    | the blog page    |
  

