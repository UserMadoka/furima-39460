Rails.application.routes.draw do
  get 'orders/index'
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
  end
end
