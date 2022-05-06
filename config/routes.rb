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

  resources :posts
  post 'posts/confirm', to: 'posts#new_confirm', as: 'confrirm_new'
  post 'posts/confirm', to: 'posts#edit_confirm', as: 'confrirm_edit'

  # post 'posts/upload', to: 'posts#upload'
  # resources :posts do 
  #   collection {post :import }
  # end
  post 'posts/download', to: 'posts#download', as: 'posts_download'
  post 'posts/upload', to: 'posts#upload'


  resources :posts, only: [:new, :create, :show] do
    collection do #This is important
      post :confirm #This is important
    end
  endx
end
