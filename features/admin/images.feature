@image_upload
Feature: Images
  In order to include images in a blog post
  the author will need to be able to upload image files

Background:
  Given that the administrator password is "imageadmin"
  And I am logged in with password "imageadmin"
  And the following images:
  | name              |
  | sample-image.png  |
  | another-image.gif |
  And I am on the images page

Scenario: View images
  Then I should see "sample-image.png"
  And I should see "another-image.gif"

Scenario: Add new image
  When I attach the file "features/upload_images/sample.png" to "picture"
  And I press "Upload"
  Then I should see "Image successfully uploaded"
  And I should see "sample-image.png"

Scenario: Delete image
  When I follow "sample-image.png"
  And I go to the images page
  Then I should not see "sample-image"
  And I should see "another-image"
