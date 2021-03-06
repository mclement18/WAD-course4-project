Rails.application.routes.draw do
  root to: 'home#index'
  
  scope '/:locale' do
    root to: 'home#index'
    
    get 'login', to: 'sessions#new'
    delete 'logout', to: 'sessions#destroy'
    get 'signup', to: 'users#new'
    post 'signup', to: 'users#create'
  
    get  '/account', to: 'account#edit'
    patch '/account', to: 'account#update'
  
    namespace :account do
      resources :tips, only: [:index]
      resources :favourites, only: [:index]
    end
  
    resources :tips do
      resources :comments, only: [:create]
    end
  
    resources :sessions, only: [:new, :create, :destroy]
  
    resources :users do
      resources :favourites, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
