class Api::RidersController < Api::ApiController
  
  before_action :is_rider? , except: [:index]

  def index

    riders = Rider.all 
    if riders.empty?
      render json: { message: "Riders not found" } , status: :no_content
    else
      render json: riders , status: :ok
    end

  end


  def show

    rider = Rider.find_by(id: current_user.userable.id)
    if rider
      render json: rider , status: :ok
    else
      render json: { message: "Rider not found" } , status: :not_found
    end

  end

  

  def update
    rider = Rider.find_by(id: current_user.userable.id)
    if rider
      rider.aadhar_no = params[:aadhar_no]
      if rider.save
        render json: rider , status: :accepted
      else
        render json: { error: rider.errors.full_messages } , status: :unprocessable_entity
      end
    else
      render json: { message: "Rider not found" } , status: :not_found
    end
  end

  

  def is_rider?
    unless user_signed_in? && current_user.rider?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end
  end

end
