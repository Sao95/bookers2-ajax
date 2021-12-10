Rails.application.routes.draw do
  devise_for :users

  root :to => "homes#top"
  get 'home/about' => 'homes#about'

  resources :users,only: [:new,:create,:show,:index,:edit,:update] do
    member do # resources以外の別のルーティングを追加
      get :followings, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  get '/search', to: 'searches#search'

end