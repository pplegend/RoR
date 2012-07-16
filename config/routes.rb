Store::Application.routes.draw do
  get "orders/new"
  get "orders/checkout"

  get "rates/index"
  get "rates/create"
  get "rates/destroy"

  get "comments/index"
  get "comments/create"
  get "comments/destroy"

  get "checkouts/index"
  get "checkouts/place_order"
  get "checkouts/thank_you"
  
  resources :posts
   resources :forums do
   resources :topics
  end
  resources :topics, :only=>[:create,:destroy]
  resources :users
  resources :orders
  resources :sessions, :only=>[:new, :create, :destroy]
  resources :products do
   resources :comments
  end
    resources :products do
   resources :rates
  end
  resources :categories do
   resources :products
  end
  resources :users do
    member do
       get :address
    end
  end
  root :to=>'products#home_page'
  match "products/search", :to=>"products#search"
  match '/checkouts/place_order', :to=>'checkouts#place_order'
  match '/signin', :to=>'sessions#new'
  match '/signup', :to=>'users#new'
  match '/logout', :to=>'sessions#destroy'
  match '/add_item', :to=>'carts#add'
  match '/cart_item_list', :to=>'carts#cart_items_list', :as=>'cart_items_list'
  match '/forget_password/', :to=>'users#forget_password'
  match '/reset_password/(:email)', :to=>'users#reset_password',:constraints => { :email => /[^\/]+/}, :as=>'reset_password'
  match '/recover_password/(:email/:code)', :to=>'users#recover_password',:constraints => { :email => /[^\/]+/}
  match '/auth/:provider/callback', :to=>'sessions#auth_create'
  match 'user/active/:email/:code' => 'users#active_user', :constraints => { :email => /[^\/]+/}
  # The priority is based upon order of creation:
  # first created -> highest priority.

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
