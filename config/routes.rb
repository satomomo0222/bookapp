Rails.application.routes.draw do
  namespace :admin do
      resources :adminusers
      resources :users
      resources :outputs
      resources :books

      root to: "adminusers#index"
    end
  # devise_for :adminusers
  devise_for :adminusers, controllers: {
    sessions: 'adminusers/sessions',
    :registrations => 'adminusers/registrations',
    :passwords => 'adminusers/passwords'
  }

  resources :books, shallow: true do
    post '/outputs/search', to:'outputs#search'
    get '/outputs/old_order', to:'outputs#old_order'
    get '/outputs/good_order', to:'outputs#good_order'
    resources :outputs do
      resource :favorites, only: [:create, :destroy]
    end
  end

  devise_for :users
  root to:'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/profile/edit', to:'users#edit'
  post '/profile/edit', to:'users#update'
  resources :users

  # 基本情報編集後の同じ画面に戻るようにした
  as :user do
    get 'users/edit',:to =>'devise/registrations#edit',:as => :user_root
  end

  #キーワード検索後
  post '/books/search', to:'books#search'
  # post '/outputs/search', to:'outputs#search'
      
end