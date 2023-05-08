class DriversController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @cid = params[:id]
  end

  def update
    driver = Driver.find(current_user.userable.id)
    puts "================================================"
    
    puts "================================================"
    driver.standby_city = params[:driver][:standby_city]
    if driver.save
      redirect_to driver_dash_path
    else
      render :edit_standby_city
    end
  end

  def destroy
  end

  def dash
    
  end

  def edit_standby_city
    @driver = Driver.find(current_user.userable.id)
  end
  
  

  def available_ride
     @available = BookingRequest.where(city: "Coimbatore" , booking_status: "available" , vehicle_type: "Bike" )
  end
end
