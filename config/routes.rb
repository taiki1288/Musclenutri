Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :users, only: [:index, :show]
  get 'search' => 'users#search'

  resources :posts do
    resources :reviews, only: [:index, :create]
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

end
