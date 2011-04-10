require 'test_helper'

class BlogControllerTest < ActionController::TestCase

  test "post should save with exitsing post returns a success" do
    currentpost = Post.create!(
      :title => 'title',
      :body => 'body'
    )

    get :post, :slug => 'title'
    assert_response :success
    assert_not_nil assigns(:post)
    assert_not_nil assigns(:comment)
    assert_nil assigns(:comment_saved)
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
      post :post, { :comment => comment_params, :slug => currentpost.slug }
    end
    
    assert_response :success
    assert_not_nil assigns(:post)
    assert_not_nil assigns(:comment)
    assert_not_nil assigns(:comment_saved)
  end
end
