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
    resources :outputs do
      resource :favorites, only: [:create, :destroy]
    end
  end

  devise_for :users
  root to:'static_pages#home'
  # root '/', to:'books#show'
  get '/about', to:'static_pages#about'
  get '/profile/edit', to:'users#edit'
  post '/profile/edit', to:'users#update'
  resources :users

  # 基本情報編集後の同じ画面に戻るようにした
  as :user do
    get 'users/edit',:to =>'devise/registrations#edit',:as => :user_root
  end

  #フォロー機能
  resources :relationships, only: [:create, :destroy]
  
end