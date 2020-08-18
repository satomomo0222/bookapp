Rails.application.routes.draw do
  devise_for :users
  root to:'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/profile/edit', to:'users#edit'
  # get '/users/mypage', to:'users#mypage'
  # post '/profile/update', to:'users#update'
  resources :users
end
