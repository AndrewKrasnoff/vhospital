Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'patients/registrations'
  }

  resources :categories
  
  root 'home#index'
  
end
