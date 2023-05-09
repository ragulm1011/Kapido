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
  
  def rating_change
    @paymentId = params[:driver][:id]
    @payment = Payment.find(@paymentId)
    @driver = Driver.find(@payment.driver_id)
    @oldRating = @driver.driver_rating
    @newRating = (@oldRating + params[:driver][:driver_rating].to_i)/2
    @driver.update(driver_rating: @newRating)
    redirect_to rider_dash_path
  end
  

  def available_ride
     @available = BookingRequest.where(city: "Coimbatore" , booking_status: "available" , vehicle_type: "Bike" )
  end
end
