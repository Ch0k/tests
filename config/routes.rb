Rails.application.routes.draw do
  devise_for :users
  resources :tests do 
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end
  end
  resources :categories
  resources :users, only: [:index]
  #root to: "categories@index"
  root 'tests#index'
end
