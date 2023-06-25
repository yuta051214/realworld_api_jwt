Rails.application.routes.draw do

  scope :api do
    # log in
    post 'auth/login', to: 'authentications#login'

    # User
    resources :users, only: [:create]
    put 'user', to: 'users#custom_update'
    get 'user', to: 'users#current'

    # Article
    resources :articles, param: :slug
  end
end
