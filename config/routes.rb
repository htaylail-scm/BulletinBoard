Rails.application.routes.draw do
  root "main#index"
  get "about", to: "about#index"
 
end
