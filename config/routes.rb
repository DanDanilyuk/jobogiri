Rails.application.routes.draw do
  devise_for :users
  get 'search', to: 'jobs#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'jobs#home'
  resources :jobs
  resources :user_jobs
end
