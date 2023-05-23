class Api::RidesController < Api::ApiController

  before_action :is_valid_user?

  
  def index
    rides = Ride.all
    if rides.empty?
      render json: { message: "Rides not found" } , status: :no_content
    else
      render json: rides , status: :ok
    end
  end



  def show
   
    ride = Ride.find_by(id: params[:id].to_i)
    if ride
      if ride.rider_id == current_user.userable.id || ride.driver_id == current_user.userable.id 
        render json: ride , status: :ok
      else
        render json: { message: 'You are not authorized to view this page' } , status: :forbidden
      end
    else
      render json: { message: "No ride found with the id #{params[:id].to_i}" } , status: :not_found
    end

  end

  
  def create
    

    if current_user.rider?
      render json: {  message: "You are not authorized to view this page"} , status: :forbidden
      return
    end

    ride = Ride.new()
    ride.rider_id = params[:rider_id]
    ride.driver_id = current_user.userable.id
    ride.booking_request_id = params[:booking_id]
    ride.ride_date = Date.today()

    if ride.save
      render json: ride , status: :accepted
    else
      render json: { error: ride.errors.full_messages } , status: :unprocessable_entity

    end
    

  end

 
  def update
    

    if current_user.rider?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end


    ride = Ride.find_by(id: params[:id].to_i)
    if ride
      if ride.driver_id == current_user.userable.id
        ride.ride_date = Date.today()
        if ride.save
          render json: ride , status: :ok
        else
          render json: { errors: ride.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page "} , status: :forbidden
      end
    else
      render json: { message: "No ride available with the id #{params[:id].to_i}"} , status: :not_found
    end
  end


  def destroy
    
    if current_user.rider?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end


   

    ride = Ride.find_by(id: params[:id].to_i)
    if ride
      if ride.driver_id == current_user.userable.id
        if ride.destroy
          render json: { message: "Ride destroyed" } , status: :ok
        else
          render json: { errors: ride.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page" } , status: :forbidden
      end
    else
      render json: { message: "No ride available with the id #{params[:id].to_i}"} , status: :not_found
    end


  end

  def own_index
    if current_user.driver?
      rides = Ride.where(driver_id: current_user.userable.id)
      if rides.empty?
        render json: { message: "No rides available" } , status: :no_content
      else
        render json: rides , status: :ok
      end
    else
      rides = Ride.where(rider_id: current_user.userable.id)
      if rides.empty?
        render json: { message: "No rides available" } , status: :no_content
      else
        render json: rides , status: :ok
      end
    end
  end

  
  private
  def is_valid_user?
    unless user_signed_in?
      render json: { message: "You are not authorized to view this page" } , status: :forbidden
    end
  end
  

   
end
