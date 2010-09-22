require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    session[:authenticated] = true
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end


end
