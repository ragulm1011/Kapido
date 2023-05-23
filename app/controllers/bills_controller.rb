class BillsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @rideId = params[:rideId]
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(ride_id: params[:bill][:ride_id] , payment_id: 25 , bill_date: Date.today() , bill_amount: params[:bill][:bill_amount])

    if @bill.save
      flash[:notice] = 'Your bill was created and wait for the payment'
      redirect_to waiting_payment_path(billId: @bill.id)
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
end
