Rails.application.routes.draw do
  namespace :api do
    post 'users', to: 'users#create'
    post 'sessions', to: 'sessions#create'
    get 'materials', to: 'materials#index'
    post 'offers', to: 'offers#create'
  end
end
