Feature: Images
  In order to show images in a blog post
  the athor will need to be able to manage the images for a post

Scenario: Add new image
  Given I have a post with title "Simple post with no images"
  And I am on the posts page
  When I follow "Edit" for post whose title is "Simple post with no images"
  And fill in "test/image1.png" for "picture"
  And I press "Upload"
  Then I should see "http://staticimagelocation.example.com/dir/image1.png"

Scenario: View images
  Given I have a post with title "Simple post" and the images:
  | name         |
  | sample-image |
  And I am on the posts page
  When I follow "Simple post"
  Then I should see "http://staticimagelocation.example.com/dir/sample-image.png"

Scenario: Delete image
  Given I have a post with title "Simple post" and the images:
  | name         |
  | sample-image |
  And I am on the posts page
  When I follow "Edit" for post whose title is "Simple post with no images"
  And I follow "delete" for image whose title is "sample-image"
  Then I should not see "sample-image"
