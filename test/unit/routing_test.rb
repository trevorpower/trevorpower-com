require 'test_helper'

class RoutingTest < ActionController::TestCase

  test "default page is the home index action" do
    assert_routing '/', {:controller => 'home', :action => 'index'} 
  end

  test "the route for a post contains slug and no ids" do
    assert_routing '/blog/my-first-post', {:controller => 'blog', :action => 'post', :slug => 'my-first-post'}
  end
end 
