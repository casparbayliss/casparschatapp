Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users
  resources :users
  resources :notifications, only: [:index] do
    collection do
      post :mark_as_read
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :chats, only: [:index, :create, :show] do
    resources :messages, only: [:index, :create]
  end
  mount ActionCable.server => '/cable'
end
