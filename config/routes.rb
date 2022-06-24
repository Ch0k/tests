Rails.application.routes.draw do
  get 'favorites/update'
  devise_for :users
  resources :favorites, only: [:update]
  resources :tests_users, only: %i[show update] do
    member do
      get :result
      #post :gist
    end
  end
  resources :tests do 
    resources :comments, only: [:create, :index]
    member do
      post :start
      patch :upvote
      patch :downvote
    end
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end
  end
  resources :categories
  resources :users, only: [:index, :edit, :update] do
    member do
      get :favorite_tests
    end
  end
  root 'tests#index'
end
