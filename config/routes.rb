Rails.application.routes.draw do
  devise_for :users
  resources :tweets
  get "profile", to: "user#new"
  post "profile", to: "user#createProfile"

  root "tweets#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
