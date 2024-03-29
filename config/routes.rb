Askacountry::Application.routes.draw do
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
  # match ':controller(/:action(/:id))(.:format)'
  
  root :to => 'home#index'
  
  match 'about' => "home#about", :via => :get, :as => :about
  match 'shuffle' => "home#shuffle", :via => :get, :as => :shuffle
  
  match 'search' => "home#search", :via => :get, :as => :search
  
  resources :user_sessions, :only => [:create]
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  match '/auth/:provider/callback' => "authorizations#create"
  match '/auth/failure'  => "authorizations#failure"
  match '/auth/:provider'  => "authorizations#blank"
  
  resources :polls, :only => [:new, :create]
  
  resources :comments, :only => [:create, :destroy]
  resources :ballots, :only => [:update]
  
  
  resources :users, :except => [:new, :index]
  
  match 'signup'  => "users#new", :as => :signup

  resources :countries, :path => "", :only => [:show] do
    member do
      post 'watch'
      post 'unwatch'
    end
    
    resources :poll_pack, :only => [:new, :index, :create]
    resources :polls, :path => "", :except => [:index] do
      resources :ballots, :only => [:create]
      member do
        post 'follow'
        post 'unfollow'
      end
    end
  end
  
  # match "/:country_id/:id"  => "polls#show", :via => :get, :as => :country_poll
end

# ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :no_prefixes => true })
