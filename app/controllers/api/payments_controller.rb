class Api::PaymentsController < Api::ApiController


  skip_before_action :verify_authenticity_token
  

  def index
    @payments = Payment.all
    if @payments.empty?
      render json: { message: "Payments not found" } , status: :no_content
    else
      render json: @payments , status: :ok
    end
  end



  def show
    @payment = Payment.find_by(id: params[:id])
    if @payment
      render json: @payment, status: :ok
    else
      render json: { message: "Payment not found" } , status: :not_found
    end
  end

  

  def create

    @payment = Payment.new()
    @payment.rider_id = params[:rider_id]
    @payment.driver_id = params[:driver_id]
    @payment.mode_of_payment = params[:mode_of_payment]
    @payment.amount = params[:amount]
    @payment.credentials = params[:credentials]
    @payment.payment_date = Date.today()
    @payment.remarks = params[:remarks]
    @payment.bill_no = params[:bill_no]

    if @payment.save 
      render json: @payment , status: :created
    else
      render json: { error: @payment.errors.full_messages } , status: :unprocessable_entity
    end

  end


  def update
    @payment = Payment.find(params[:id])
    if @payment
      @payment.amount = params[:amount]
      if @payment.save
        render json: @payment , status: :accepted
      else
        render json: { error: @payment.errors.full_messages } , status: :unprocessable_entity
      end
    else
      render json: { message: "Payment not found"} , status: :not_found
    end
  end

  def destroy
    @payment = Payment.find_by(id: params[:id])
    if @payment
      if @payment.destroy
        render json: { message: "Payment destroyed" } , status: :ok
      else
        render json: { error: @payment.errors.full_messages } , status: :forbidden
      end
    else
        render json: { message: "Payment not found"} , status: :not_found
    end
  end

  

  

  
end
