class Api::LocationsController < Api::ApiController

 
  
  skip_before_action :verify_authenticity_token
  
  def index
    @locations = Location.all
    if @locations.empty?
      render json: { message: "No locations found" } , status: :no_content
    else
      render json: @locations , status: :ok
    end
  end

  def show
    @location = Location.find_by(id: params[:id])
    if @location
      render json: @location, status: :ok
    else
      render json: { message: "No location found with the id #{params[:id]}" } , status: :not_found
    end
  end


  def create
    location = Location.new
    location.location_name = params[:location_name]
    location.landmark = params[:landmark]
    location.city = params[:city]
    location.pincode = params[:pincode]
    location.rider_id = params[:rider_id]

    if location.save
      render json: location, status: :created
    else
      render json: {error: location.errors.full_messages} , status: :unprocessable_entity
    end
  end

 
  def update
    location = Location.find_by(id: params[:id])
    if location
      location.landmark = params[:landmark]
      if location.save
        render json: location , status: :accepted
      else
        render json: { error: location.errors.full_messages } , status: :unprocessable_entity
      end
    else
        render json: { message: "Location not found with the id #{params[:id]}" } , status: :not_found
    end
  end

  def destroy
    location = Location.find_by(id: params[:id])
    if location
      if location.destroy
        render json: { message: 'Location deleted successfully' } , status: :ok
      else
        render json: { error: location.errors.full_messages } , status: :unprocessable_entity
      end
    else
      render json: { message: "No location found with the id #{params[:id]}" } , status: :not_found
    end
  end


  #Custom API's
  def get_all_default_locations
    @locations = Location.where(rider_id: 3)
    if @locations 
      render json: @locations , status: :ok
    else
      render json: { message: "No Default Locations Available " } , status: :no_content
    end
  end



  def get_all_rider_personal_locations
    @locations = Location.where(rider_id: params[:id])
    if @locations
      render json: @locations , status: :ok
    else
      render json: { message: "No locations available for the rider with id #{params[:id]}"} , status: :no_content
    end
  end
  
end
