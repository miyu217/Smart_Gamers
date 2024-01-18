Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  get "search" => "games#search"

  resources :users do
    resources :requests
  end

  resources :games do
    resources :reviews do
      member do
        post 'toggle_good'
      end
    end
  end

  resources :admins do
    member do
      put 'approve'
      put 'reject'
    end
  end
end
