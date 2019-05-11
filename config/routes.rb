Rails.application.routes.draw do
  namespace :api do
    post 'users', to: 'users#create'
    get 'users', to: 'users#show'
    post 'users/update', to: 'users#update'
    
    post 'sessions', to: 'sessions#create'
    get 'materials', to: 'materials#index'
    
    post 'offers', to: 'offers#create'
    get 'offers', to: 'offers#index'
    post 'offers/:id', to: 'offers#delete'
    
    get 'donations', to: 'donations#index'
  end
end
