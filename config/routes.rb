Rails.application.routes.draw do

  resources :product, only: [:index, :create, :show, :update, :destroy]
  resources :category, only: [:index, :create, :show, :update, :destroy]

end
