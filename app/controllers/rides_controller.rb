class RidesController < ApplicationController

  before_action :authenticate_user!

  
  def index
    @rides
    if current_user.driver?
      @rides = Ride.where(driver_id: current_user.userable.id)
    else
      @rides = Ride.where(rider_id: current_user.userable.id)
    end

    @rides = @rides.reverse()
  end

  

  def new
    # @booking = BookingRequest.find(params[:bid])
    # @ride = Ride.new
    # @ride.booking_request_id = params[:bid]
    # @ride.date = Date.now()
    # if current_user.role = 'Driver'
    #   @ride.driver_id = current_user.userable.id 
    # else 
    #   @ride.rider_id = current_user.userable.id
    # end
    # @ride.save
    if current_user.rider? 
      flash[:alert] = "Unauthorized action"
      redirect_to rider_dash_path
      return 
    end
    
    booking = BookingRequest.find_by(id: params[:id])
    current_user.userable.update(riding_status: "on_ride")

    
    @ride = Ride.new(booking_request_id: params[:id].to_i, driver_id: current_user.userable.id , rider_id: booking.rider_id , ride_date: Date.today())
    @ride.save
    booking.update(booking_status: 'booked')
    flash[:notice] = "You are on the ride" 
    current_user.userable.update(current_ride_id: @ride.id)  
    redirect_to riding_path(id: @ride.id)
  end

  def create
  end

  

  def waiting

    if current_user.driver?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
      
    end


    @bookingId = params[:id].to_i
    currentBooking = BookingRequest.find_by(id: @bookingId)

    unless current_user.userable.id == currentBooking.rider_id
      flash[:alert] = "Unauthorized action"
      redirect_to rider_dash_path
      return 
    end


    if currentBooking.booking_status == 'booked'
      flash[:notice] = "Your waiting was over"
      redirect_to finish_waiting_path(bid: currentBooking.id)
      return 
    end


  end

  def finish_waiting
    
    if current_user.driver?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
    end


    bid = params[:bid].to_i
    ride = Ride.find_by(booking_request_id: bid)
    
    if ride.save
      flash[:notice] = "You are moved to ride"
      current_user.userable.update(current_ride_id: ride.id)
      redirect_to riding_path(id: ride.id)
    else
      render :finish_waiting_path
    end

    
  end


  def riding
    @rideId = params[:id].to_i
    @ride = Ride.find_by(id: @rideId)
    @driver = User.find_by(userable_id: @ride.driver_id)
    @rider = User.find_by(userable_id: @ride.rider_id)
    if current_user.rider?
      bill = Bill.find_by(ride_id: @rideId)
      if bill
        flash[:notice] = "Ride ended successfully"
        redirect_to new_payment_path(rideId: @rideId)
      end
    end
  end

  

   
end
