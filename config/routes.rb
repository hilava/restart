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
  get 'jobs/:id/edit', to: "jobs#edit", as: :edit_job
  get 'jobs/:id', to: "jobs#show", as: :job
  put 'jobs/:id', to: "jobs#update"
  patch 'jobs/:id', to: "jobs#update"
  delete 'jobs/:id', to: "jobs#destroy"
# ----------------------------------COMPANY/JOB ROUTES--------------------------
  post 'companies/:company_id/jobs', to: "jobs#create"
  get 'companies/:company_id/jobs/new', to: "jobs#new", as: :new_company_job
#-------------catch all--------------------------------------------------------------#
  # match "*path", to: redirect('/404'), via: :all
  get "*any", to: redirect('/404'), via: :all

end
