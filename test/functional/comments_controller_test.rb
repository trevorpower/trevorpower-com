require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    session[:authenticated] = true
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should create comment" do
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
      post :create, { :comment => comment_params , :post_id => currentpost.id.to_param }
    end

    assert_redirected_to blog_post_path(:slug => assigns(:post).slug)
  end

end
