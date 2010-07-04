require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the slug replaces spaces with hyphens" do
    assert_equal "simple-title", Post.create_slug("simple title")
  end
end
