Rails.application.routes.draw do
  devise_for :users
  resources :notes

  namespace :api do
    resources :notes, only: [ :index ]
  end

  root to: 'welcome#index'
end
