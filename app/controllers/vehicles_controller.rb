class VehiclesController < ApplicationController

  before_action :authenticate_user!  

  def index
  end

  def show
  end

  def new
    @vehicle = Vehicle.new()
  end

  def create

    
    @vehicle = Vehicle.new(create_params)
    @vehicle.driver_no = current_user.userable.id 
    p "================================================================"
    p @vehicle
    p "================================================================"

    if @vehicle.save
      flash[:notice] = 'Your Vehicle added successfully'
      redirect_to driver_dash_path
    else
      render :new
    end
    

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def change_primary_vehicle
    @vehicles = Vehicle.where(driver_no: current_user.userable.id)
  end

  def set_primary_vehicle
    @vehicleId = params[:id]
    current_user.userable.update(primary_vehicle_id: @vehicleId)
    redirect_to driver_dash_path
  end
  private
  def create_params
    params.require(:vehicle).permit(:vehicle_name , :vehicle_type , :no_of_seats , :vehicle_no)
  end
end
