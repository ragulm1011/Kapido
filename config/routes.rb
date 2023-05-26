Rails.application.routes.draw do
  use_doorkeeper
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
  get "/drivers/show" => "drivers#show"
  get "/drivers/edit" => "drivers#edit"
  patch "/drivers/update" => "drivers#update"
  get "/riders/show" => "riders#show"

  resources :drivers
  resources :riders , only: [:show]
  resources :booking_requests , only: [:new , :create , :destroy]
  resources :locations , only: [:new , :create]
  resources :rides , only: [:index , :new , :create]
  resources :bills , only: [:new , :create]
  resources :payments , only: [:new , :create]
  resources :vehicles , only: [:new , :create , :destroy]

  #Exception Routes
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'

 
  

   # API routes
   namespace :api , default: {format: :json} do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    # use_doorkeeper
   
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

    #Custom API's
    get "/drivers/drivers_with_standby_city" , controller: :drivers , action: :drivers_with_standby_city , as: :drivers_with_standby_city
    get "/drivers/drivers_with_rating_above_3" , controller: :drivers , action: :drivers_with_rating_above_3 , as: :drivers_with_rating_above_3
    get "/locations/get_all_default_locations" , controller: :locations , action: :get_all_default_locations , as: :get_all_default_locations
    get "/locations/get_all_rider_personal_locations" , controller: :locations , action: :get_all_rider_personal_locations , as: :get_all_rider_personal_locations
    get "/vehicles/get_vehicles_with_vehicle_type" , controller: :vehicles , action: :get_vehicles_with_vehicle_type , as: :get_vehicles_with_vehicle_type


    #own_index_routes
    get "/bills/your_bills" , controller: :bills , action: :your_bills 
    get "/booking_requests/your_booking_requests" , controller: :booking_requests , action: :your_booking_requests
    get "/payments/your_payments" , controller: :payments , action: :your_payments
    get "/rides/your_rides" , controller: :rides , action: :your_rides
    get "/vehicles/your_vehicles" , controller: :vehicles , action: :your_vehicles
    
  
    resources :drivers 
    resources :riders
    resources :booking_requests
    resources :locations
    resources :rides
    resources :bills
    resources :payments
    resources :vehicles
   

  end



  
  
end
