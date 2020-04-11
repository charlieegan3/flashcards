Rails.application.routes.draw do
  get '/', to: redirect("index.html")

  scope :api do
    resources :cards, only: [:index] do
      post :update, on: :collection
    end
  end
end
