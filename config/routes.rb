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


  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'
  # get "posts", to: "posts#index"

  resources :posts
  post 'posts/confirm', to: 'posts#new_confirm', as: 'confrirm_new'
  post 'posts/confirm', to: 'posts#edit_confirm', as: 'confrirm_edit'


end
