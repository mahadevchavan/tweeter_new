Rails.application.routes.draw do
  get 'comments/create'
  resources :tweets do
      resources :comments
  end

  get "profile", to: "user#new"
  post "profile", to: "user#createProfile"

  root "tweets#index"
  devise_for :users,
             controllers: {
               omniauth_callbacks: "users/omniauth_callbacks"
             }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
