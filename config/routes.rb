Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  root to: "homes#top"
  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :create, :new, :destroy, :edit, :update] do
    resources :post_comments, only: [:create]
  end


   get 'mypage' => 'users#mypage', as: 'mypage'
   post 'search' => 'searches#search'
end
