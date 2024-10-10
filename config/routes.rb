Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, only: [:index, :show, :create, :new, :destroy, :edit, :update]


  get 'homes/about' => 'homes#about', as: 'about'
  get 'mypage' => 'users#mypage', as: 'mypage'
end
