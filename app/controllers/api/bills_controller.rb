class Api::BillsController < Api::ApiController 

  
  before_action :is_driver? , except: [:index, :show , :own_index]

  
  def index   
    bills = Bill.all
    if bills.empty?
      render json: { message: "No bills available" } , status: :ok
    else
      render json: bills , status: :ok
    end

  end


  
  def show 
    
    if current_user.driver?

      rides_id_array = Ride.where(driver_id: current_user.userable.id).pluck(:id)
      bills = Bill.all
      final_bills_id_array = Array.new

      rides_id_array.each do |i|
        bills.each do |j|
          if j.ride_id == i
            final_bills_id_array.push(j.id)
          end
        end
      end

      unless final_bills_id_array.include?(params[:id].to_i)
        render json: { message: "You are not authorized to view this page "} , status: :forbidden
        return 
      end

      bill = Bill.find_by(id: params[:id].to_i)

      if bill
        render json: bill , status: :ok
      else
        render json: { message: "No bill available with the given id #{params[:id].to_i}"} , status: :no_content
      end

    else

      rides_id_array = Ride.where(rider_id: current_user.userable.id).pluck(:id)
     
      bills = Bill.all
      final_bills_id_array = Array.new

      rides_id_array.each do |i|
        bills.each do |j|
          if j.ride_id == i
            final_bills_id_array.push(j.id)
          end
        end
      end

      

      unless final_bills_id_array.include?(params[:id].to_i)
        render json: { message: "You are not authorized to view this page"} , status: :forbidden
        return 
      end
      
      bill = Bill.find_by(id: params[:id].to_i)
      
      if bill
        render json: bill , status: :ok
      else
        render json: {message: "No bill available with the id #{params[:id].to_i}"} , status: :no_content
      end

    end

  end


  

  
  def create
    
    bill = Bill.new()

    bill.ride_id = params[:ride_id]
    bill.payment_id = 25
    bill.bill_date = Date.today()
    bill.bill_amount = params[:bill_amount]

    if bill.save
      render json: bill , status: :created
    else
      render json: {error: bill.errors.full_messages} , status: :unprocessable_entity
    end

  end


  #No routes found error
  def update 
    rides_id_array = Ride.where(driver_id: current_user.userable.id).pluck(:id)
    bills = Bill.all
    final_bills_id_array = Array.new

    rides_id_array.each do |i|
      bills.each do |j|
        if j.ride_id == i
          final_bills_id_array.push(j.id)
        end
      end
    end


    unless final_bills_id_array.include?(params[:id].to_i)
      render json: {message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end

    billId = params[:id]
    bill = Bill.find(billId)
    updatedBillAmount = params[:bill_amount]

    if bill
      bill.bill_amount = updatedBillAmount
      if bill.save
        render json: bill , status: :accepted
      else
        render json: { error: bill.errors.full_messages } , status: :unprocessable_entity
      end
    else
      render json: {error: "No bill with id #{billId}"} , status: :not_found
    end

  end


  #No routes found error

  def destroy 

    rides_id_array = Ride.where(driver_id: current_user.userable.id).pluck(:id)
    bills = Bill.all
    final_bills_id_array = Array.new

    rides_id_array.each do |i|
      bills.each do |j|
        if j.ride_id == i
          final_bills_id_array.push(j.id)
        end
      end
    end

    

    unless final_bills_id_array.include?(params[:id].to_i)
      render json: {message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end


    billId = params[:id]
    bill = Bill.find(billId)
    if bill
      if bill.destroy
        render json: { message: "Bill deleted successfully" } , status: :ok
      else
        render json: {error: bill.errors.full_messages} , status: :unprocessable_entity

      end
    else
      render json: {error: "No bill with id #{billId}"} , status: :not_found
    end
  end


  def own_index

    if current_user.rider?
      rides = Ride.where(rider_id: current_user.userable.id)
      rides_id_array = rides.pluck(:id)
      bills = Bill.all
      finalBills = Array.new

      rides_id_array.each do |i|
        bills.each do |j|
          if j.ride_id == i
            finalBills.push(j)
          end
        end
      end

      if finalBills.size > 0
        render json: finalBills, status: :ok
      else
        render json: {message: "No bills available for you"} , status: :no_content
      end
      

      
    else

      rides = Ride.where(driver_id: current_user.userable.id)
      rides_id_array = rides.pluck(:id)
      bills = Bill.all
      finalBills = Array.new

      rides_id_array.each do |i|
        bills.each do |j|
          if j.ride_id == i
            finalBills.push(j)
          end
        end
      end

      if finalBills.size > 0
        render json: finalBills, status: :ok
      else
        render json: { message: "No bills available for you"} , status: :no_content
      end
      



    end

  end

  private
  def is_driver?
    unless user_signed_in? && current_user.driver?
      render json: {message: "You are not authorized to view this page"} , status: :unauthorized
    end
  end
  
end
