Rails.application.routes.draw do
  root to: 'cards#index'
  resources :cards, only: [:index]
end
