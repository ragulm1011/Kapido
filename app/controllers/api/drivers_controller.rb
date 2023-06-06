class Api::DriversController < Api::ApiController
  
  # before_action :authenticate_user!
  before_action :is_driver? , except: [:index, :show , :drivers_with_standby_city , :drivers_with_rating_above_3]

  
  def index

    drivers = Driver.all
    if drivers.empty?
      render json: {message: "No drivers available"} , status: :no_content
    else
      render json: drivers , status: :ok
    end

  end


  def show

    driver = Driver.find(params[:id])
    if driver
      render json: driver , status: :ok
    else
      render json: {message: "No driver found with the id #{params[:id]}"} , status: :not_found
    end

  end

  
 

 

  def update
  
  if current_user.userable.update(standby_city: params[:city])
    render json: current_user.userable , status: :ok
  else
    render json: {error: current_user.userable.errors.full_messages } , status: :unprocessable_entity
  end
  
  end

  
  

  def available_ride
    
    primaryVehicle = Vehicle.find_by(id: current_user.userable.primary_vehicle_id)
    available = BookingRequest.where(city: params[:city] , booking_status: "available" , vehicle_type: primaryVehicle.vehicle_type)
    
    
    if available.size == 0
     
      render json: {  message: "No rides available" } , status: :no_content
    else
      
      render json: available , status: :ok
    end

  end



  #Custom Api Methods
  def drivers_with_standby_city
    
    drivers = Driver.where(standby_city: params[:city])
    
    if drivers.empty?
      render json: { messsage: "No drivers available in the city #{params[:city]}" } , status: :no_content
    else
      render json: drivers , status: :ok
    end
  end

  

  def drivers_with_rating


    if params[:rating].to_i < 0 || params[:rating].to_i > 5
      render json: { message: "The rating must be within the range of 0-5" } , status: :bad_request
      return 
    end


    driver = Driver.where("driver_rating >= ?", params[:rating].to_i)
    if driver.empty?
      render json: { message: "No drivers available with the given rating #{params[:rating].to_i}" } , status: :no_content
    else
      render json: driver , status: :ok
    end
  end


  private
  def is_driver?
    unless user_signed_in? && current_user.driver?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
    end
  end

end
