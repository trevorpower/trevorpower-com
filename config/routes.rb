ActionController::Routing::Routes.draw do |map|

  map.resources( :posts,
                 :member => { :publish => :put, :hide => :put },
                 :has_many => [:comments] )
  
  map.resources :comments, :member => { :spam => :put }

  map.resources(  :images,
                  :only => [ :index, :create, :destroy ],
                  :requirements => { :id => /[a-zA-Z0-9\-\.]+/ } )
  
  map.resources :sessions

  map.home '', :controller => 'home', :action => 'index'
  map.about 'about', :controller => 'about', :action => 'index'
  map.contact 'contact', :controller => 'contact', :action => 'index'
  map.send_mail 'send_mail', :controller => 'contact', :action => 'send_mail', :method => 'post'
  map.blog 'blog.:format', :controller => 'blog', :action => 'index'
  map.blog_post 'blog/:id', :controller => 'blog', :action => 'post'

  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'

end
