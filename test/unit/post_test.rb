require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def assert_creates_slug(title, slug)
    assert_equal slug, Post.create_slug(title)
  end
  
  test "that slugs created as expected" do
    assert_creates_slug "Simple Title", "simple-title"
    assert_creates_slug "UPPERCASE TITLE", "uppercase-title"
    assert_creates_slug "comma, seperated, list", "comma-seperated-list"
    assert_creates_slug "slash/question mark?", "slash-question-mark"
    assert_creates_slug "---?complex-questions?-&-answers--with, symbols-?", "complex-questions-answers-with-symbols"
    assert_creates_slug "what's up with google's site","whats-up-with-googles-site"
  end
end
