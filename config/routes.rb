Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
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
  get "/rides/waiting" , controller: :rides , action: :waiting , as: :waiting
  get "/booking_requests/destroy" , controller: :booking_requests , action: :destroy , as: :booking_requests_destroy
  get "/drivers/available_ride" , controller: :drivers , action: :available_ride , as: :available_ride
  get "drivers/edit_standby_city" , controller: :drivers , action: :edit_standby_city , as: :edit_standby_city
  get "/drivers/city_change" , controller: :drivers , action: :city_change , as: :city_change
  get "/rides/riding" , controller: :rides , action: :riding , as: :riding
  get "/rides/finish_waiting" , controller: :rides , action: :finish_waiting , as: :finish_waiting
  get "/payments/waiting_payment" , controller: :payments , action: :waiting_payment , as: :waiting_payment
  get "/payments/successful" , controller: :payments , action: :successful , as: :successful
  post "/drivers/rating_change" , controller: :drivers , action: :rating_change , as: :rating_change
  get "/vehicles/change_primary_vehicle" , controller: :vehicles , action: :change_primary_vehicle , as: :change_primary_vehicle
  get "/vehicles/set_primary_vehicle" , controller: :vehicles , action: :set_primary_vehicle , as: :set_primary_vehicle
  

  resources :drivers 
  resources :riders
  resources :booking_requests
  resources :locations
  resources :rides
  resources :bills
  resources :payments
  resources :vehicles
end
