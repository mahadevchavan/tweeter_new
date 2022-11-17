Rails.application.routes.draw do
  # resources :follows
  devise_for :users,
             controllers: {
               omniauth_callbacks: "users/omniauth_callbacks"
             }
  get "comments/create"
  resources :tweets do
    resources :comments
  end
  resources :users do
    member { get :following, :followers }
  end
  get "profile", to: "users#new"
  post "profile", to: "users#createProfile"

  resources :relationships, only: %i[create destroy]

  root "tweets#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
