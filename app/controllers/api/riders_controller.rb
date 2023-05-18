class Api::RidersController < Api::ApiController
  
  skip_before_action :verify_authenticity_token
  
  def index
    @riders = Rider.all 
    if @riders.empty?
      render json: { message: "Riders not found" } , status: :no_content
    else
      render json: @riders , status: :ok
    end
  end

  def show
    @rider = Rider.find(params[:id])
    if @rider
      render json: @rider , status: :ok
    else
      render json: { message: "Rider not found" } , status: :not_found
    end
  end

  # def new
  # end

  # def create
  # end

  # def edit
  # end

  def update
    @rider = Rider.find_by(id: params[:id])
    if @rider
      @rider.aadhar_no = params[:aadhar_no]
      if @rider.save
        render json: @rider , status: :accepted
      else
        render json: { error: @rider.errors.full_messages } , status: :unprocessable_entity
      end
    else
      render json: { message: "Rider not found" } , status: :not_found
    end
  end

  # def destroy
  # end


end
