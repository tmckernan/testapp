Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#homepage'

  resource :account, only: [:new, :create, :destroy]
  resources :recipients, only: [:index, :new, :create] do
    resources :payments, only: [:index, :new, :create]
  end
end
