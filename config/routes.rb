Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  get "search" => "games#search"

  resources :users
  resources :games
end
