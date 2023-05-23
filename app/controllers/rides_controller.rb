class RidesController < ApplicationController

  before_action :authenticate_user!

  
  def index
    @rides
    if current_user.driver?
      @rides = Ride.where(driver_id: current_user.userable.id)
    else
      @rides = Ride.where(rider_id: current_user.userable.id)
    end
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
    end
    
    booking = BookingRequest.find(params[:id])
   
    @ride = Ride.new(booking_request_id: params[:id], driver_id: current_user.userable.id , rider_id: booking.rider_id , ride_date: Date.today())
    @ride.save
    booking.update(booking_status: 'booked')
    flash[:notice] = "You are on the ride"    
    redirect_to riding_path(id: @ride.id)
  end

  def create
  end

  

  def waiting

    if current_user.driver?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
    end


    @bookingId = params[:id]
    currentBooking = BookingRequest.find(@bookingId)

    unless current_user.userable.id == currentBooking.rider_id
      flash[:alert] = "Unauthorized action"
      redirect_to rider_dash_path
    end


    if currentBooking.booking_status == 'booked'
      
      redirect_to finish_waiting_path(bid: currentBooking.id)
    end


  end

  def finish_waiting
    
    if current_user.driver?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
    end


    bid = params[:bid]
    ride = Ride.find_by(booking_request_id: bid)
    
    if ride.save
      flash[:notice] = "You are moved to ride"
      redirect_to riding_path(id: ride.id)
    else
      render :finish_waiting_path
    end
  end


  def riding
    @rideId = params[:id]
    @ride = Ride.find(@rideId)
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
