require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "the slug replaces spaces with hyphens" do
    assert_equal "simple-title", Post.create_slug("simple title")
  end
  test "the slug is lowercase" do
    assert_equal "tolower", Post.create_slug("TOLOWER")
  end
  test "the slug removes commas" do
    assert_equal "simpletitle", Post.create_slug("simple,title")
  end
end
