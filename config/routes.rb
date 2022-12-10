Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about' => 'homes#about',as: 'about'
  get '/users' => 'users#alluser',as: 'alluser'
  resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  resources :users, only: [:edit, :show, :update, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
