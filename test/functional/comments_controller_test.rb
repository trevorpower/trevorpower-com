require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    session[:authenticated] = true
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should create comment" do
    currentpost = Post.create!(:title => 'title', :body => 'body')

    assert_difference('Comment.count') do
      post :create, { :comment => { :body => 'a comment' } , :post_id => currentpost.id.to_param }
    end

    assert_redirected_to blog_post_path(assigns(:post))
  end

end
