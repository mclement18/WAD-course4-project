Rails.application.routes.draw do
  root to: 'home#index'
  
  scope '/:locale' do
    get 'sessions/new'

    get 'login', to: 'sessions#new'
    delete 'logout', to: 'sessions#destroy'
    get 'signup', to: 'users#new'
  
    root to: 'home#index'
  
    get  '/account', to: 'account#edit'
    patch '/account', to: 'account#update'
  
    namespace :account do
      resources :tips, only: [:index]
    end
  
    resources :tips do
      resources :comments, only: [:create]
    end
  
    resources :sessions, only: [:new, :create, :destroy]
  
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
