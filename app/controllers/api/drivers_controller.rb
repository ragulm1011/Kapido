class Api::DriversController < Api::ApiController
  
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
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

  
  #Polymorphically Has one User 
  def create
  end

 

  def update
   driver = Driver.find(params[:id])
   if driver
    p "==================="
    p params[:city]
    p "============="

    driver.standby_city = params[:city]

    p "==================="
      driver.standby_city
    p "================"
    if driver.save
      render json: driver , status: :accepted
    else
      render json: {  error: driver.errors.full_messages } , status: :unprocessable_entity
    end
   else
    render json: {message: "No driver with the id #{params[id]}"} , status: :not_found
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
end
