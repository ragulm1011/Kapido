class Api::PaymentsController < Api::ApiController


  before_action :is_rider? , except: [:index, :show , :own_index]
  

  def index
    payments = Payment.all
    if payments.empty?
      render json: { message: "Payments not found" } , status: :no_content
    else
      render json: payments , status: :ok
    end
   

  end



  def show
   
    payment = Payment.find_by(id: params[:id].to_i)
    if payment
      if payment.rider_id == current_user.userable.id || payment.driver_id == current_user.usrebale.id
        render json: payment, status: :ok
      else
        render json: { message: "You are not authorized to view this page" } , status: :forbidden
      end
    else
      render json: { message: "No payment available with the id #{params[:id].to_i}" } , status: :not_found
    end

  end

  

  def create

    payment = Payment.new()
    payment.rider_id = current_user.userable.id
    payment.driver_id = params[:driver_id]
    payment.mode_of_payment = params[:mode_of_payment]
    payment.amount = params[:amount]
    payment.credentials = params[:credentials]
    payment.payment_date = Date.today()
    payment.remarks = params[:remarks]
    payment.bill_no = params[:bill_no]

    if payment.save 
      render json: payment , status: :created
    else
      render json: { error: payment.errors.full_messages } , status: :unprocessable_entity
    end

  end


  def update

    payment = Payment.find_by(id: params[:id].to_i)
    if payment
      if payment.rider_id == current_user.userable.id
        payment.amount = params[:amount]
        if payment.save
          render json: payment , status: :ok
        else
          render json: { errors: payment.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page" } , status: :forbidden
      end
    else
      render json: {message: "No payment found with id #{params[:id]}"} , status: :not_found
    end

  end



  def destroy
  
    payment = Payment.find_by(id: params[:id].to_i)
    if payment
      if payment.rider_id == current_user.userable.id 
        if payment.destroy
          render json: { message: "Payment destroyed" } , status: :ok
        else
          render json: { errors: payment.errors.full_messages } , status: :unprocesable_entity
        end
      else
        render json: { message: "You are not authorized to view this page" } , status: :forbidden
      end
    else
      render json: { message: "Payment not found with the id #{params[:id].to_i}" } , status: :not_found
    end

  end

  def your_payments
    payments = current_user.userable.payments
    if payments.size == 0
      render json: { message: "No Payments available for you "} , status: :no_content
    else
      render json: payments , status: :ok
    end
  end


  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
    end
  end

  

  
end
