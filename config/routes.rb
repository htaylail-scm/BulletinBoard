Rails.application.routes.draw do
  root "main#index"

  get "about", to: "about#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"
  
  delete "logout", to: "sessions#destory"

  # get "posts", to: "posts#index"
  # get "posts/:id", to: "posts#show"

  resources :posts
 
end
