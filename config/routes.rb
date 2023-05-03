Rails.application.routes.draw do
 
  # devise_for :users
  
  devise_for :users , controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root controller: :homes , action: :index , as: :home
  get "/drivers/dashboard" , controller: :drivers , action: :dash , as: :driver_dash
  get "/riders/dashboard" , controller: :riders , action: :dash , as: :rider_dash
  resources :drivers 
  resources :riders
  resources :booking_requests
  resources :locations
end
