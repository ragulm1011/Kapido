class Api::LocationsController < Api::ApiController

 
  
  before_action :is_rider? , except: [:index]
  
  def index

    locations = Location.all
    if locations.empty?
      render json: { message: "No locations found" } , status: :no_content
    else
      render json: locations , status: :ok
    end
  end


  def show
    
    all_locations_id_array = Location.where(rider_id: current_user.userable.id).pluck(:id)
    all_default_locations_id_array = Locations.where(rider_id: 3).pluck(:id)
    

    unless all_locations_id_array.include?(params[:id].to_i) && all_default_locations_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end

    location = Location.find_by(id: params[:id])

    if location
      render json: location, status: :ok
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
    location.rider_id = current_user.userable.id

    if location.save
      render json: location, status: :created
    else
      render json: {error: location.errors.full_messages} , status: :unprocessable_entity
    end
  end

 
  def update

    all_locations_id_array = Location.where(rider_id: current_user.userable.id).pluck(:id)
    unless all_locations_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end
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

    all_locations_id_array = Location.where(rider_id: current_user.userable.id).pluck(:id)
    unless all_locations_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end
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
    locations = Location.where(rider_id: 3)
    if locations 
      render json: locations , status: :ok
    else
      render json: { message: "No Default Locations Available " } , status: :no_content
    end
  end



  def get_all_rider_personal_locations
    locations = Location.where(rider_id: current_user.userable.id)
    if locations
      render json: locations , status: :ok
    else
      render json: { message: "No locations available for the rider #{current_user.name}" } , status: :no_content
    end
  end


  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      render json: { message: "You are not authorized to view this page" } , status: :forbidden
      return 
    end
  end
  
end
