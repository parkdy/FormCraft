FormCraft::Application.routes.draw do

  resources :users do
    member do
      get 'change_password'
      get 'send_activation_email'
      get 'activate'
      get 'reset_password'
      put 'update_password'
    end

    collection do
      get 'forgot_password'
      post 'send_recovery_email'
    end
  end

  resource :session, only: [:new, :create, :destroy]

  resources :forms, only: [:show, :create, :update, :destroy, :new, :edit] do
    resources :responses, only: [:new, :create, :index, :destroy]

    member do
      get 'send_responses_email'
    end
  end

  namespace :api do
    resources :forms, only: [:show, :create, :update, :destroy]
    resources :fields, only: [:show, :create, :update, :destroy]
    resources :field_options, only: [:show, :create, :update, :destroy]
  end

  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'

  get 'form_editor' => 'form_editors#index'

  root to: 'static_pages#index'

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
end
