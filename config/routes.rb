Rails.application.routes.draw do


  root "main#index"

  get "about", to: "about#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  # get "sign_in", to: "sessions#new"
  # post "sign_in", to: "sessions#create"
  get "user/login", to: "sessions#new"
  post "user/login", to: "sessions#create"


  get "user/password", to: "passwords#edit", as: :edit_password
  patch "user/password", to: "passwords#update"
  
  delete "logout", to: "sessions#destory"

  resources :posts
  post 'posts/confirm', to: 'posts#new_confirm', as: 'confirm_new'
  post 'posts/confirm', to: 'posts#edit_confirm', as: 'confirm_edit'

  post 'posts', to: 'posts#download', as: 'posts_download'
  post 'posts/upload', to: 'posts#upload'

  get 'posts/search', to: 'posts#search'


end
