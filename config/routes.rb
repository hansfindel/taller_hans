TallerHans::Application.routes.draw do
  
  match 'users/:username' => "users#show"
  match 'users/:username/edit' => "users#edit"
  
  resources :comments

  get "home/index"
  get "home/home"
  get "sessions/new"
  
  resources :types
  resources :users
  resources :sessions
  resources :password_resets
  resources :alumns
  resources :profesors
  resources :courses


  root :to => "home#index"
  get "home" => "home#home", :as => "home"
  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => 'login'	
  get "log_out" => "sessions#destroy", :as => 'logout'

  get "lista/users" => "users#lista", :as => 'lista'
  get "reset_password/:id" => "users#reset_password"
  
  match 'comments/:id/destruir' => 'comments#destruir', :as => 'destruir'
  match 'comments/:id/ocultar' => 'comments#ocultar', :as => 'ocultar'
  
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
