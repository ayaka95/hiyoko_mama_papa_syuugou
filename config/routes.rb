Rails.application.routes.draw do
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:index, :show, :create, :new, :destroy]
  devise_for :users
  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'
  get 'mypage' => 'users#mypage', as: 'mypage'
end
