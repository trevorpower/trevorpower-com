Feature: Images
  In order to include images in a blog post
  the author will need to be able to upload image files

Scenario: View images
  Given I have a the following images:
  | name              |
  | sample-image.png  |
  | another-image.gif |
  And I am on the images page
  Then I should see "http://staticimagelocation.example.com/dir/sample-image.png"
  Then I should see "http://staticimagelocation.example.com/dir/another-image.gif"

Scenario: Add new image
  Given I am on the images page
  When I fill in file with name "sample.png" for "picture"
  And I press "Upload"
  Then I should see "http://staticimagelocation.example.com/dir/sample.png"

Scenario: Delete image
  Given I have a post with title "Simple post" and the images:
  | name         |
  | sample-image |
  And I am on the posts page
  When I follow "Edit" for post whose title is "Simple post"
  And I follow "Delete" for "sample-image"
  Then I should not see "sample-image"
