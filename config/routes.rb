Rails.application.routes.draw do
  devise_for :users
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
    end
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end
  end
  resources :categories
  resources :users, only: [:index, :edit, :update]
  root 'tests#index'
end
