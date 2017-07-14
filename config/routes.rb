Rails.application.routes.draw do
  devise_for :users

  resources :notes do
    resources :encouragements, only: [ :new, :create ]
  end

  namespace :api do
    resources :notes, only: [ :index ]
  end

  root to: 'welcome#index'
end
