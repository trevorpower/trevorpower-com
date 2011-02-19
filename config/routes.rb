Blog::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  map.resources :posts, :member => { :publish => :put, :hide => :put } do |_post|
   _post.resources :comments, :except => [:new, :edit, :update]
  end

  map.resources :comments, :except => [ :new, :create ], :member => { :hide => :put, :show => :put}

  map.resources(  :images,
                  :only => [ :index, :create, :destroy ],
                  :requirements => { :id => /[a-zA-Z0-9\-\.]+/ } )
  
  map.resources :sessions, :only => [ :create ]

  map.home '', :controller => 'home', :action => 'index'
  map.about 'about', :controller => 'about', :action => 'index'
  map.contact 'contact', :controller => 'contact', :action => 'index'
  map.send_mail 'send_mail', :controller => 'contact', :action => 'send_mail', :method => 'post'
  map.blog 'blog.:format', :controller => 'blog', :action => 'index'
  map.blog_post 'blog/:slug', :controller => 'blog', :action => 'post'

  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
