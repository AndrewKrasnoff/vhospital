Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'patients/registrations' }
  resources :doctors, only: :index
  resources :categories
  resources :appointments
  root 'home#index'

end
