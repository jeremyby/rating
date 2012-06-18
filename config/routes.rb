Oddandriches::Application.routes.draw do
  get "votings/create"

  get "votings/update"

  root :to => 'home#index'

  resources :user_sessions, :only => [:create]
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  
  resources :authorizations
  match '/auth/:provider/callback' => "authorizations#create"
  match '/auth/failure'  => "authorizations#failure"
  match '/auth/:provider'  => "authorizations#blank"
  
  resources :users
  match 'signup'  => "users#new", :as  => :signup

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
  
  match "/:country_id/:poll_id/votings"  => "votings#create", :via => :post, :as => :create_country_poll_vote
  match "votings/:id" => "votings#update", :via => :put, :as  => :update_vote
  
  match '/all/countries' => "countries#index", :as => :index_countries
  match ':country_id' => "countries#show"
  
  #match ':country_id/rating/edit' => "rating#edit", :as => :edit_rating
  
  resources :countries, :path => "", :only => [:index, :show] do
    #resources :rating, :only => [:new, :create, :update]
    resources :polls, :path => ""
  end
end
