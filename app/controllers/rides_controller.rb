class RidesController < ApplicationController
  def index
  end

  def show
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

    
    booking = BookingRequest.find(params[:id])
   
    @ride = Ride.new(booking_request_id: params[:id], driver_id: current_user.userable.id , rider_id: booking.rider_id , ride_date: Date.today())
    @ride.save
    booking.update(booking_status: 'booked')    
    redirect_to riding_path(id: @ride.id)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def waiting
    @bookingId = params[:id]
    currentBooking = BookingRequest.find(@bookingId)
    if currentBooking.booking_status == 'booked'
      redirect_to finish_waiting_path(bid: currentBooking.id)
    end
  end

  def finish_waiting
    bid = params[:bid]
    ride = Ride.find_by(booking_request_id: bid)
    
    if ride.save
      redirect_to riding_path(id: ride.id)
    else
      render :finish_waiting_path
    end
  end


  def riding
    @rideId = params[:id]
  end

  

   
end
