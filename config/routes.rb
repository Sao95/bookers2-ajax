Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users,only: [:new,:create,:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :books  do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
end