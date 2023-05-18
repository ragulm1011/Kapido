class Api::VehiclesController < Api::ApiController

  skip_before_action :verify_authenticity_token

  def index
    @vehicles = Vehicle.all
    if @vehicles.empty?
      render json: { message: "No Vehicle found." } , status: :no_content
    else
      render json: @vehicles , status: :ok
    end
  end

  def show
    @vehicle = Vehicle.find_by(id: params[:id])
    if @vehicle
      render json: @vehicle, status: :ok
    else
      render json: { message: "Vehicle not found with the id #{params[:id]}" } , status: :not_found
    end
  end

  

  def create
    
    @vehicle = Vehicle.new
    @vehicle.vehicle_name = params[:name]
    @vehicle.vehicle_type = params[:type]
    @vehicle.no_of_seats = params[:seats]
    @vehicle.driver_no = params[:driver_no]

    if @vehicle.save
      render json: @vehicle, status: :created
    else
      render json: {  error: @vehicle.errors.full_messages } , status: :unprocessable_entity

    end

  end

  
  def update
    @vehicle = Vehicle.find_by(id: params[:id])
    if @vehicle
      @vehicle.driver_no = params[:driver_no]
      if @vehicle.save
        render json: @vehicle, status: :accepted
      else
        render json: { error: @vehicle.errors.full_messages } , status: :unprocesable_entity
      end
    else
      render json: { message: "Vehicle not found with the id #{params[:id]}" } , status: :not_found
    end
  end

  def destroy
    @vehicle = Vehicle.find_by(id: params[:id])
    if @vehicle
      if @vehicle.destroy
        render json: { message: "Vehicle deleted successfully"} , status: :ok
      else
        render json: { error: @vehicle.errors.full_messages } , status: :unprocessable_entity
      end
    else
      render json: { message: "Vehicle not found with the id #{params[:id]}" } , status: :not_found
    end
  end

end
