class LocationsController < ApplicationController

  before_action :authenticate_user!
  before_action :is_rider?
  
  

  def new
    @location = Location.new
  end

  def create
    location = Location.new(create_params)
    location.rider_id = current_user.userable.id
    if location.save
      flash[:notice] = 'Location added successfully'
      redirect_to new_booking_request_path
    else
      render :new
    end
  end

  

  private
  def create_params
    params.require(:location).permit(:location_name, :landmark , :city , :pincode)
  end

  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
    end
  end
end
