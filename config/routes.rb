Rails.application.routes.draw do


  root "main#index"

  get "about", to: "about#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  # get "sign_in", to: "sessions#new"
  # post "sign_in", to: "sessions#create"
  get "user/login", to: "sessions#new"
  post "user/login", to: "sessions#create"
  delete "logout", to: "sessions#destory"



  get "user/password", to: "passwords#edit", as: :edit_password
  patch "user/password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  post "password/reset/edit", to: "password_resets#update"
  


  resources :posts
  
  post 'posts/confirm_create', to: 'posts#confirm_create', as: 'confirm_create'
  post 'posts/confirm_update', to: 'posts#confirm_update', as: 'confirm_update'

  post 'posts', to: 'posts#download', as: 'posts_download'
  post 'posts/upload', to: 'posts#upload'

  get 'posts/search', to: 'posts#search'


end
