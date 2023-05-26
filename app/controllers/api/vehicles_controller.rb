class Api::VehiclesController < Api::ApiController

  before_action :is_driver? , except: [:get_vehicles_with_vehicle_type , :index]

  def index
    vehicle = Vehicle.all
    if vehicle.empty?
      render json: { message: "No vehicle available" } , status: :no_content
    else
      render json: vehicle , status: :ok
    end
  end

  def show

    vehicle = Vehicle.find_by(id: params[:id].to_i)
    if vehicle
      if vehicle.driver_no == current_user.userable.id
        render json: vehicle , status: :ok
      else
        render json: { message: "You are not authorized to view this page" } , status: :forbidden
      end
    else
      render json: { message: "No vehicle found with the id #{params[:id]}" } , status: :not_found
    end

  end

  

  def create
    
    vehicle = Vehicle.new
    vehicle.vehicle_name = params[:name]
    vehicle.vehicle_type = params[:type]
    vehicle.no_of_seats = params[:seats]
    vehicle.driver_no = current_user.userable.id

    if vehicle.save
      render json: vehicle, status: :created
    else
      render json: {  error: vehicle.errors.full_messages } , status: :unprocessable_entity

    end

  end

  
  def update

    vehicle = Vehicle.find_by(id: params[:id].to_i)
    if vehicle
      if vehicle.driver_no == current_user.userable.id 
        vehicle.no_of_seats = params[:seats]
        if vehicle.save
          render json: vehicle, status: :accepted
        else
          render json: { error: vehicle.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page"} , status: :forbidden
      end
    else
      render json: { message:  "No vehicle found with the id #{params[:id]}" } , status: :not_found
    end
  end



  def destroy

   
    vehicle = Vehicle.find_by(id: params[:id].to_i)
    if vehicle
      if vehicle.driver_no == current_user.userable.id 
        
        if vehicle.destroy
          render json: { message: "Vehicle destroyed successfully "}, status: :ok
        else
          render json: { error: vehicle.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page"} , status: :forbidden
      end
    else
      render json: { message:  "No vehicle found with the id #{params[:id]}" } , status: :not_found
    end
    
  end


   #Custom API's
   def get_vehicles_with_vehicle_type 
    vehicles = Vehicle.where(vehicle_type: params[:vehicle_type])
    if vehicles.empty?
      render json: { message: "No vehicle available with the type #{params[:vehicle_type]}" } , status: :no_content
    else
      render json: vehicles , status: :ok
    end
   end
   
   def your_vehicles
    vehicles = Vehicle.where(driver_no: current_user.userable.id)
    if vehicles.empty?
      render json: { message: "No Vehicle found." } , status: :no_content
    else
      render json: vehicles , status: :ok
    end
   end

   private
   def is_driver?

    unless user_signed_in? && current_user.driver?
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end

   end

  

end
