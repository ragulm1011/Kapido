class Api::PaymentsController < Api::ApiController


  before_action :is_rider? , except: [:index, :show]
  

  def index
    # @payments = Payment.all
    # if @payments.empty?
    #   render json: { message: "Payments not found" } , status: :no_content
    # else
    #   render json: @payments , status: :ok
    # end
    @payments = current_user.userable.payments
    if @payments.size == 0
      render json: { message: "No Payments available for you "} , status: :no_content
    else
      render json: @payments , status: :ok
    end

  end



  def show
    # @payment = Payment.find_by(id: params[:id])
    # if @payment
    #   render json: @payment, status: :ok
    # else
    #   render json: { message: "Payment not found" } , status: :not_found
    # end

    @payments = current_user.userable.payments
    @payments_id_array = @payments.pluck(:id)

    unless @payments_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page" } , status: :forbidden
      return 
    end

    @payment = Payment.find_by(id: params[:id].to_i)

    if @payment
      render json: @payment , status: :ok
    else
      render json: { message: "No payment available with the id #{params[:id].to_i}"} , status: :no_content
    end

  end

  

  def create

    @payment = Payment.new()
    @payment.rider_id = current_user.userable.id
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
    @payments = current_user.userable.payments
    @payments_id_array = @payments.pluck(:id)

    unless @payments_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page" } , status: :forbidden
      return       
    end

    @payment = Payment.find_by(id: params[:id].to_i)

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
    @payments = current_user.userable.payments
    @payments_id_array = @payments.pluck(:id)

    unless @payments_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page" } , status: :forbidden
      return 
    end

    @payment = Payment.find_by(id: params[:id].to_i)

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


  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
    end
  end

  

  
end
