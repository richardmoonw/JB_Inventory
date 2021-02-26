Rails.application.routes.draw do

  resources :products, only: [:index, :create, :show, :update, :destroy]
end
