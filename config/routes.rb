Rails.application.routes.draw do
  get 'jobs/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'jobs#home'
  resources :jobs
end
