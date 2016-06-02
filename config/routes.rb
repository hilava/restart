Rails.application.routes.draw do
  devise_for :users
  root 'site#index'
  get 'contact', to: "site#contact", as: :contact
# -----------------------------------PROFILE ROUTES-----------------------------
  get 'profiles', to: "profiles#index", as: :profiles
  post 'profiles', to: "profiles#create"
  get 'profiles/new', to: "profiles#new", as: :new_profile
  get 'profiles/:id/edit', to: "profiles#edit", as: :edit_profile
  get 'profiles/:id', to: "profiles#show", as: :profile
  put 'profiles/:id', to: "profiles#update"
  patch 'profiles/:id', to: "profiles#update"
  delete 'profiles/:id', to: "profiles#destroy"
#------------------------------------COMPANY ROUTES-----------------------------
  post 'companies', to: "companies#create"
  get 'companies/new', to: "companies#new", as: :new_company
  get 'companies/search', to: "companies#search", as: :search_company
  get 'companies/:id', to: "companies#show", as: :company

# -----------------------------------JOBS ROUTES--------------------------------
  get 'jobs', to: "jobs#index", as: :jobs
  post 'jobs', to: "jobs#create"
  #get 'jobs/new', to: "jobs#new", as: :new_job
  get 'jobs/:id/edit', to: "jobs#edit", as: :edit_job
  get 'jobs/:id', to: "jobs#show", as: :job
  put 'jobs/:id', to: "jobs#update"
  patch 'jobs/:id', to: "jobs#update"
  delete 'jobs/:id', to: "jobs#destroy"
# ----------------------------------COMPANY/JOB ROUTES--------------------------
  post 'companies/:company_id/jobs', to: "jobs#create"
  get 'companies/:company_id/jobs/new', to: "jobs#new", as: :new_company_job


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
