class BookingRequestsController < ApplicationController
  
  before_action :authenticate_user! , :is_rider?

  

  def new
    @booking = BookingRequest.new
  end

  def create

    fromLocationId = Location.find_by(location_name: params[:booking_request][:from_location_name])
    toLocationId =   Location.find_by(location_name: params[:booking_request][:to_location_name])
    booking_request = BookingRequest.new(create_params) 
    booking_request.booking_status = "available"
    booking_request.from_location_id = fromLocationId.id
    booking_request.to_location_id = toLocationId.id
    booking_request.rider_id = current_user.userable.id


    if  booking_request.save
      flash[:notice] = "Your booking was created and wait for driver to accept the request"
      redirect_to waiting_path(id: booking_request.id)
    else
      render :new
    end
  end

  

  def destroy
    
    booking_request = BookingRequest.find_by(id: params[:bid])
    unless booking_request.rider_id == current_user.userable.id 
      flash[:alert] = "Unauthorized action"
      redirect_to rider_dash_path
    end

    booking_request.destroy
    flash[:notice] = "Your ride cancelled successfully"
    redirect_to rider_dash_path
  end

  private
  def create_params
    params.require(:booking_request).permit(:city, :vehicle_type , :from_location_name , :to_location_name)
  end

  private 
  def is_rider?
    unless user_signed_in? && current_user.rider?
      flash[:alert] = "Unauthorized action"
      if user_signed_in?
        redirect_to driver_dash_path
      else
        redirect_to new_user_sesssion_path
      end
    end
  end

end
