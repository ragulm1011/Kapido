class VehiclesController < ApplicationController

  before_action :authenticate_user!  
  before_action :is_driver?
  

  def new
    @vehicle = Vehicle.new()
  end

  def create

    
    @vehicle = Vehicle.new(create_params)
    @vehicle.driver_no = current_user.userable.id 
 

    if @vehicle.save
      flash[:notice] = 'Your Vehicle added successfully'
      redirect_to driver_dash_path
    else
      render :new
    end
    

  end

  

  def destroy
  end

  def change_primary_vehicle
    @vehicles = Vehicle.where(driver_no: current_user.userable.id)
  end

  def set_primary_vehicle
    @vehicleId = params[:id].to_i
    @vehicles = Vehicle.where(driver_no: current_user.userable.id)
    @vehicles_id_array = @vehicles.pluck(:id)

    unless @vehicles_id_array.include?(@vehicleId)
      flash[:alert] = "Unauthorized action"
      redirect_to driver_dash_path
      return 
    end

    current_user.userable.update(primary_vehicle_id: @vehicleId)
    redirect_to driver_dash_path
  end

  private
  def create_params
    params.require(:vehicle).permit(:vehicle_name , :vehicle_type , :no_of_seats , :vehicle_no)
  end

  private
  def is_driver?
    unless user_signed_in? && current_user.driver?
      flash[:alert] = "Unauthorized action"
      redirect_to rider_dash_path
    end
  end
  
end
