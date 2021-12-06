Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users,only: [:new,:create,:show,:index,:edit,:update] do
    member do # resources以外の別のルーティングを追加
      get :followings, :followers
    end
    resource :relationships, only: [:create, :destroy]
    # get :search, on: :collection
    # collection は全部のデータに対するアクションに利用する
    # member は特定のデータに対するアクションに利用する
  end

  resources :books  do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    # get :search, on: :collection
  end
  
  get '/search', to: 'searches#search'

end