class BillsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @rideId = params[:rideId]
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(ride_id: params[:bill][:ride_id] , payment_id: 1 , bill_date: Date.today() , bill_amount: params[:bill][:bill_amount])
    p "=========================="
    p @bill
    p "=========================="
    if @bill.save
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
