class DriversController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_driver? , except: [:rating_change]
  
  

  def show

    
    unless params[:id].to_i == current_user.userable.id
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
    end

    @driver = Driver.find_by(id: params[:id])

  end

  

  
  def edit

    unless params[:id] == current_user.userable.id
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
    end

    @cid = params[:id]
    
  end

  def update
    driver = Driver.find_by(id: current_user.userable.id)
    driver.standby_city = params[:driver][:standby_city]
    if driver.save
      flash[:notice] = "Your standing city changed successfully"
      redirect_to driver_dash_path
    else
      render :edit_standby_city
    end
  end

  

  def dash
    @rides = Ride.where(driver_id: current_user.userable.id)
    @payments = Payment.where(driver_id: current_user.userable.id)
    @earnings = 0
    @payments.each do |payment|
      if payment.amount
        @earnings = @earnings + payment.amount
      end
    end
    @rating = current_user.userable.driver_rating
    
    
  end

  def edit_standby_city
    @driver = Driver.find_by(id: current_user.userable.id)
  end
  
  def rating_change

    if current_user.driver?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
    end

    @paymentId = params[:driver][:id].to_i
    @payment = Payment.find_by(id: @paymentId)
    @driver = Driver.find_by(id: @payment.driver_id)
    @oldRating = @driver.driver_rating
    @newRating = (@oldRating + params[:driver][:driver_rating].to_i)/2
    @driver.update(driver_rating: @newRating)
    flash[:notice] = "Rating updated for the driver"
    redirect_to rider_dash_path
  end
  

  def available_ride
    @primaryVehicle = Vehicle.find_by(id: current_user.userable.primary_vehicle_id)
    @available = BookingRequest.where(city: current_user.userable.standby_city , booking_status: "available" , vehicle_type: @primaryVehicle.vehicle_type)
  end

  private
  def is_driver?
    
    unless user_signed_in? && current_user.driver? 
      flash[:alert] = "Unauthorized action"
      if user_signed_in?
        redirect_to rider_dash_path
      else
        redirect_to new_user_session_path
      end
    end
  end
end
