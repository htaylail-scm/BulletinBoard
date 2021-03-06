Rails.application.routes.draw do


  root "main#index"
  get "user/login", to: "sessions#new"
  post "user/login", to: "sessions#create"
  delete "user/logout", to: "sessions#destory"

  resources :users
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
  post 'users/confirm', to: 'users#confirm_create', as: :confirm_user_create
  post 'users/:id/confirm', to: 'users#confirm_update', as: :confirm_user_update
  get "profile/:id", to: "users#show", as: :user_profile



  get "user/password", to: "passwords#edit", as: :edit_password
  patch "user/password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"
  


  resources :posts  
  post 'posts/confirm', to: 'posts#confirm_create', as: 'confirm_create'
  post 'posts/:id/confirm', to: 'posts#confirm_update', as: 'confirm_update'

  get 'posts', to: 'posts#download', as: 'download_post'
  post 'posts/upload', to: 'posts#upload', as: 'upload_post'
  


 
end
