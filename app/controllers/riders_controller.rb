class RidersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
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

end
