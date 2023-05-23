class RidersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_rider?
  
 
  def show
    
    unless params[:id] == current_user.userable.id
      flash[:alert] = "Unauthorized action"
      redirect_to rider_dash_path
    end

    @rider = Rider.find(params[:id])
  end

  

  def dash
   @rides = Ride.where(rider_id: current_user.userable.id)
    @payments = Payment.where(rider_id: current_user.userable.id)
    @expenses = 0
    @payments.each do |payment|
      if payment.amount
      @expenses = @expenses + payment.amount
      end
    end

  end

  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
    end
  end

end
