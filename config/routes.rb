Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :posts

  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resource :profile, only: [:show, :edit, :update]
end
