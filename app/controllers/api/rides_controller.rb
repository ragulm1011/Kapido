class Api::RidesController < Api::ApiController

  skip_before_action :verify_authenticity_token

  
  def index
    @rides = Ride.all
    if @rides.empty?
      render json: { message: "Rides not found" } , status: :no_content
    else
      render json: @rides , status: :ok
    end
  end

  def show
    @ride = Ride.find_by(id: params[:id])
    if @ride
      render json: @ride, status: :ok
    else
      render json: { message: "Ride not found" } , status: :not_found
    end
  end

  
  def create
    @ride = Ride.new()
    @ride.rider_id = params[:rider_id]
    @ride.driver_id = params[:driver_id]
    @ride.booking_request_id = params[:booking_id]
    @ride.ride_date = Date.today()

    if @ride.save
      render json: @ride , status: :accepted
    else
      render json: { error: @ride.errors.full_messages } , status: :unprocessable_entity

    end
  end

 
  def update
    @ride = Ride.find_by(id: params[:id])
    if @ride
      @ride.ride_date = Date.today()
      if @ride.save
        render json: @ride , status: :accepted
      else
        render json: {error: @ride.errors.full_messages} , status: :unprocessable_entity
      end
    else
      render json: { message: "Ride not found" } , status: :not_found
    end
  end

  def destroy
    @ride = Ride.find_by(id: params[:id])
    if @ride
      if @ride.destroy
        render json: { message: "Ride destroyed" } , status: :ok
      else
        render json: { error: @ride.errors.full_messages } , status: :forbidden
      end
    else
      render json: { message: "Ride not found" } , status: :not_fond
    end
  end

  
  

   
end
