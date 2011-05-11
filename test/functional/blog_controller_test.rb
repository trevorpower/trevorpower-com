require 'test_helper'

class BlogControllerTest < ActionController::TestCase

  test "post should save with exitsing post returns a success" do
    currentpost = Post.create!(
      :title => 'title',
      :body => 'body'
    )

    get :comment, :slug => 'title'
    assert_response :success
    assert_not_nil assigns(:post)
    assert_not_nil assigns(:comment)
    assert_nil assigns(:comment_saved)
  end

  test "comment should return error if commenting not enabled" do
    ENV['commenting_active'] = nil 
    currentpost = Post.create!(
      :title => 'title',
      :body => 'body'
    )

    get :comment, :slug => 'title'
    assert_response 403
  end

  test "post should save comment" do
    ENV['commenting_active'] = 'true'
    currentpost = Post.create!(
      :title => 'title',
      :body => 'body'
    )

    comment_params = {
      :email => 'test@example.com',
      :name => 'tester',
      :body => 'a comment' 
    }
    
    assert_difference('Comment.count') do
      post :comment, { :comment => comment_params, :slug => currentpost.slug }
    end
    
    assert_response :success
    assert_not_nil assigns(:post)
    assert_not_nil assigns(:comment)
    assert_not_nil assigns(:comment_saved)
    assert_not_nil assigns(:comment).post_title
  end
end
