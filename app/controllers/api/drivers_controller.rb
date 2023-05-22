class Api::DriversController < Api::ApiController
  
  # before_action :authenticate_user!
  before_action :is_driver? , except: [:index, :show , :drivers_with_standby_city , :drivers_with_rating_above_3]

  
  def index

    @drivers = Driver.all
    if @drivers.empty?
      render json: {message: "No drivers available"} , status: :no_content
    else
      render json: @drivers , status: :ok
    end

  end


  def show

    @driver = Driver.find(params[:id])
    if @driver
      render json: @driver , status: :ok
    else
      render json: {message: "No driver found with the id #{params[:id]}"} , status: :not_found
    end

  end

  
 

 

  def update
  
  if current_user.userable.update(standby_city: params[:city])
    render json: @current_user.userable , status: :ok
  else
    render json: {error: current_user.userable.errors.full_messages } , status: :unprocessable_entity
  end
  
  end



  def destroy
  end

  
  

  def available_ride
    
    @primaryVehicle = Vehicle.find(params[:id])
     @available = BookingRequest.where(city: params[:city] , booking_status: "available" , vehicle_type: @primaryVehicle.vehicle_type)

     if @available.empty?
      render json: {  message: "No rides available" } , status: :no_content
    else
      render json: @available , status: :ok
    end
  end



  #Custom Api Methods
  def drivers_with_standby_city
    @drivers = Driver.where(standby_city: params[:city])
    if @drivers.empty?
      render json: { messsage: "No drivers available in the city #{params[:city]}" } , status: :no_content
    else
      render json: @drivers , status: :ok
    end
  end

  def drivers_with_rating_above_3
    @driver = Driver.where("driver_rating >= ?", 3)
    if @driver.empty?
      render json: { message: "No drivers available with rating greater than 3" } , status: :no_content
    else
      render json: @driver , status: :ok
    end
  end


  private
  def is_driver?
    return user_signed_in? && current_user.driver?
  end

end
