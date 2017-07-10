Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :notes, only: [:new, :create, :show]
end
