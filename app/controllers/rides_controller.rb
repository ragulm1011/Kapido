class RidesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @booking = BookingRequest.find(params[:bid])
    @ride = Ride.new
    @ride.booking_request_id = params[:bid]
    @ride.date = Date.now()
    if current_user.role = 'Driver'
      @ride.driver_id = current_user.userable.id 
    else 
      @ride.rider_id = current_user.userable.id
    end
    @ride.save
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
      redirect_to new_ride_path(bid: @bookingId)
    end
  end
end
