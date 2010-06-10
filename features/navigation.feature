Feature: Navigation
  In order to easily navigate the site
  The users will need to see a comment set of navigations link on all pages
 
  Scenario Outline: All pages have links to the main pages of the site
    Given I am on <Source Page>
    When I follow <Link>
    Then I should be on <Destination Page>
    Examples:
    | Source Page      | Link      | Destination Page |
    | the home page    | "Contact" | the contact page |
    | the home page    | "About"   | the about page   |
    | the home page    | "Blog"    | the blog page    |
    | the about page   | "Contact" | the contact page |
    | the about page   | "Home"    | the home page    |
    | the about page   | "Blog"    | the blog page    |
    | the contact page | "Home"    | the home page    |
    | the contact page | "About"   | the about page   |
    | the contact page | "Blog"    | the blog page    |
    | the blog page    | "Contact" | the contact page |
    | the blog page    | "About"   | the about page   |
    | the blog page    | "Home"    | the home page    |
