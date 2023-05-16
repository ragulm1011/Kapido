class PaymentsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    
    @bill = Bill.find_by(ride_id: params[:rideId])
    @ride = Ride.find(params[:rideId])
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

  def edit
  end

  def update
  end

  def destroy
  end

  def waiting_payment
    @payment = Payment.find_by(bill_no: params[:billId])
    if @payment
      @bill = Bill.find(params[:billId])
      @bill.payment_id = @payment.id
      @bill.save
      redirect_to successful_path
    end
  end

  def successful
    if current_user.rider?
      @driver = Driver.new
      @paymentId = params[:paymentId]
    end
  end

  private
  def create_params
    params.require(:payment).permit(:rider_id , :driver_id , :mode_of_payment , :amount , :credentials , :remarks , :bill_no)
  end
end
