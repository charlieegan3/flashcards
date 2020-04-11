Rails.application.routes.draw do
  scope :api do
    resources :cards, only: [:index] do
      post :update, on: :collection
    end
  end
end
