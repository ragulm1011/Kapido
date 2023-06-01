class BillsController < ApplicationController

  before_action :authenticate_user!
  before_action :is_driver?


  

  def new
    
    @ride = Ride.find_by(id: params[:rideId].to_i)
    @driver_id = @ride.driver_id

    unless @driver_id == current_user.userable.id 
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
    end

    current_user.userable.update(riding_status: "off_ride")

    @rideId = params[:rideId]
    @bill = Bill.new

  end

  def create
    @bill = Bill.new(ride_id: params[:bill][:ride_id] , payment_id: 41 , bill_date: Date.today() , bill_amount: params[:bill][:bill_amount])
    
    if @bill.save
      
      flash[:notice] = 'Your bill was created and wait for the payment'
      redirect_to waiting_payment_path(billId: @bill.id)
    else
      render :new
    end
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
