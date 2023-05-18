class Api::BillsController < Api::ApiController 

  skip_before_action :verify_authenticity_token

  #Done
  def index 
    @bills = Bill.all
    if @bills.empty?
      render json: { message: "Bills not found" } , status: :no_content
    else
      render json: @bills , status: :ok
    end

  end

  #Not Working - Directing to index action
  def show 
    @billId = params[:id]
    @bill = Bill.find_by(id: @billId)
    if @bill
      render json: @bill , status: :ok
    else
      render json: { message: "Bill not found" } , status: not_found
    end

  end

  #Done
  def create
    @bill = Bill.new(ride_id: params[:ride_id] , payment_id: 25 , bill_date: Date.today() , bill_amount: params[:bill_amount])
   
    if @bill.save
      render json: @bill , status: :created
    else
      render json: {error: @bill.errors.full_messages} , status: :unprocessable_entity
    end
  end


  #No routes found error
  def update 
    @billId = params[:id]
    @bill = Bill.find(@billId)
    @updatedBillAmount = params[:bill_amount]
    if @bill
      @bill.bill_amount = @updatedBillAmount
      if @bill.save
        render json: @bill , status: :accepted
      else
        render json: { error: @bill.errors.full_messages } , status: unprocessable_entity
      end
    else
      render json: {error: "No bill with id #{@billId}"} , status: :not_found
    end

  end


  #No routes found error

  def destroy 
    @billId = params[:id]
    @bill = Bill.find(@billId)
    if @bill
      if @bill.destroy
        render json: { message: "Bill deleted successfully" } , status: :ok
      else
        render json: {error: @bill.errors.full_messages} , status: :unprocessable_entity

      end
    else
      render json: {error: "No bill with id #{@billId}"} , status: :not_found
    end
  end

  
end
