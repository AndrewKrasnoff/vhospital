Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'patients/registrations' }
  resources :doctors, except: :destroy
  resources :patients, only: :index
  resources :categories, except: :destroy
  resources :appointments
  root 'home#index'

end
