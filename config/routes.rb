Rails.application.routes.draw do
  # resources :articles

  scope :api do
    post 'auth/login', to: 'authentications#login'

    resources :users, only: [:create]
    put 'user', to: 'users#custom_update'
    get 'user', to: 'users#current'
  end
end
