Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :create, :new]
  devise_for :users
  root to: "homes#top"
  get 'homes/about' => 'homes#about', as: 'about'
end
