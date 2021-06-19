Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :users, only: [:index, :show] do
    resources :follows, only: [:show, :create]
    resources :unfollows, only: [:show, :create]
  end

  get 'search' => 'users#search'

  resources :posts do
    resources :reviews, only: [:index, :create]
    resource :like, only: [:show, :create, :destroy]
  end

  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resource :profile, only: [:show, :edit, :update]

  namespace :api, format: :json do
    namespace :v1 do
      resource :likes, only: [:create, :destroy]
    end
  end

  resources :tags do
    get 'posts', to: 'posts#tags'
  end

  get 'goods/search'
  
  resources :rooms, only: [:index, :show, :create]
  resources :messages, only: [:create, :edit, :update, :destroy]
  resources :notifications, only: [:index, :destroy]
end
