class LocationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @location = Location.new
  end

  def create
    location = Location.new(create_params)
    if location.save
      redirect_to new_booking_request_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def create_params
    params.require(:location).permit(:location_name, :landmark , :city , :pincode)
  end
end
