Blog::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :posts do
    member do
      put 'publish'
      put 'hide'
    end
    resources :comments, :except => [:new, :edit, :update]
  end

  match 'comments/:id/delete' => 'comments#destroy', :via => 'post', :as => :destroy_comment

  resources :comments, :except => [ :new, :create, :destroy, :update ] do
    collection do
      put 'deactivate'
      put 'activate'
    end
    member do
      put 'publish'
      put 'hide'
    end
  end

  resources :images, :only => [ :index, :create, :destroy ], :constraints => { :id => /[a-zA-Z0-9\-\.]+/ }
  
  resources :sessions, :only => [ :create ]

  match '' => 'home#index', :as => :home
  match 'about' => 'about#index', :as => :about
  match 'contact' => 'contact#index', :as => :contact, :via => ['get', 'post']
  match 'contact/send_mail' => 'contact#send_mail', :via => 'post', :as => :send_mail
  match 'blog' => 'blog#index', :as => :blog
  match 'blog/:slug' => 'blog#post', :via => 'get', :as => :blog_post
  match 'blog/:slug' => 'blog#comment', :via => 'post', :as => :save_comment

  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

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
