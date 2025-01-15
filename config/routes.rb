Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :post_comments, only: [:index, :destroy]
    resources :users, only: [:destroy]
    resources :groups, only: [:index, :destroy]
  end

  scope module: :public do
    devise_for :users
    root to: "homes#top"
    get 'mypage' => 'users#mypage', as: 'mypage'
    post 'search' => 'searches#search'
    resources :posts, only: [:index, :show, :create, :new, :destroy, :edit, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :groups, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
      resource :group_user, only: [:create, :destroy]
      resources :group_posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
        resources :group_comments, only: [:create, :destroy]
      end
    end
    

  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
end
