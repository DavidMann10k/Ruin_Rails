RR::Application.routes.draw do


  resources :availabilities

#forums
  resources :divisions
  match "/divisions/dex_up/:id/" => "divisions#dex_up"
  resources :forums
  match "/forums/dex_up/:id/" => "forums#dex_up" 
  resources :topics  
  resources :posts
  match "posts/:id/toggle_publish" => "posts#toggle_publish"
  
#user, session, authentication
  resources :users
  match "users/:action/:id" => "users#:action"
  
  resources :authentications, :only => [:index, :create, :destroy]
  
  match '/auth/:service/callback', :to => 'authentications#auth_callback' 
  match '/auth/failure',           :to => 'authentications#failure'  
  match "/authenticate",           :to => "authentications#authenticate"
  match "/signout",                :to => "authentications#signout"
  
  match "/register",         :to => "users#new"
  
  
#root and pages
  root :to => 'pages#root'
  
  match "/about",            :to => "pages#about"
  match "/about_ruin_rails", :to => "pages#about_ruin_rails"
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
