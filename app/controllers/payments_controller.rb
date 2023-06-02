class PaymentsController < ApplicationController

  before_action :authenticate_user!

  

  def new
    
    @bill = Bill.find_by(ride_id: params[:rideId].to_i)
    @ride = Ride.find_by(id: params[:rideId].to_i)
    @payment = Payment.new()
  end

  def create
    @payment = Payment.new(create_params)
    @payment.payment_date = Date.today()
    if @payment.save
        flash[:notice] = "Payment done successfully"
        redirect_to successful_path(paymentId: @payment.id)
    else
      render :new
    end
  end

  

  def waiting_payment
    @payment = Payment.find_by(bill_no: params[:billId])
    if @payment
      @bill = Bill.find_by(id: params[:billId])
      @bill.payment_id = @payment.id
      @bill.save
      redirect_to successful_path
    end
  end

  def successful
    if current_user.rider?
      @driver = Driver.new
      @paymentId = params[:paymentId].to_i
    end

    current_user.userable.update(current_ride_id: nil)
  end

  private
  def create_params
    params.require(:payment).permit(:rider_id , :driver_id , :mode_of_payment , :amount , :credentials , :remarks , :bill_no)
  end
end
