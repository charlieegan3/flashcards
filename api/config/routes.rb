Rails.application.routes.draw do
  resources :cards, only: [:index] do
    post :update, on: :collection
  end
end
