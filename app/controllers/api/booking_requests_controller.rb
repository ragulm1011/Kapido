class Api::BookingRequestsController < Api::ApiController
  
  # before_action :authenticate_user!
  before_action :is_rider? , except: [:index , :show]


  def index 

    if current_user.rider?
      render json: {message: "You are not authorized to view this page "} , status: :forbidden
      return 
    end

    breqs = BookingRequest.where(city: current_user.userable.standby_city , booking_status: "available")
    
    if breqs.empty?
      render json: "No booking requests found for you at the moment" , status: :no_content
    else
      render json: breqs, status: :ok
    end

  end


  def show 

    if current_user.rider?
      render json: {message: "You are not authorized to view this page "} , status: :forbidden
      return       
    end

    breqs = BookingRequest.where(city: current_user.userable.standby_city)
    breqs_id_array = breqs.pluck(:id).map(&:to_i)
    
    # p breqs_id_array
    # p params[:id]

    unless breqs_id_array.include?(params[:id].to_i)
      render json: { mesage: "You are not authorized to view this page" } , status: :forbidden
      return 
    end


    breq = BookingRequest.find(params[:id].to_i)

    if breq
      render json: breq, status: :ok
      return 
    else
      render json: "No BookingRequest found with id #{params[:id].to_i}" , status: :not_found
      return 
    end
  end



  def create

    bookingRequest = BookingRequest.new()

    fromLocation = Location.find_by(location_name: params[:from_location_name])
    toLocation =   Location.find_by(location_name: params[:to_location_name])

    bookingRequest.from_location_id = fromLocation.id
    bookingRequest.to_location_id = toLocation.id

    bookingRequest.booking_status = "available"
    bookingRequest.from_location_name = params[:from_location_name]
    bookingRequest.to_location_name = params[:to_location_name]

    bookingRequest.city = params[:city]
    bookingRequest.vehicle_type = params[:vehicle_type]

    bookingRequest.rider_id = current_user.userable.id
    


    if  bookingRequest.save
      render json: bookingRequest , status: :created
    else
      render json: {  errors: bookingRequest.errors.full_messages } , status: :unprocessable_entity
    end

  end

  def update 
    b_requests = BookingRequest.where(rider_id: current_user.userable.id)
    b_requests_id_array = b_requests.pluck(:id)


    puts(b_requests)
    puts current_user.userable.id

    unless b_requests_id_array.include?(params[:id].to_i)
      render json: { message: "You are not authorized to view this page"}
    end


    breq = BookingRequest.find(params[:id])
    updatedCity = params[:city]

    if breq
      breq.city = updatedCity
      if breq.save
        render json: breq, status: :accepted
      else
        render json: { error: breq.errors.full_messages} , status: :unprocessable_entity
      end
    else
      render json: "No BookingRequest found" , status: :not_found
    end
  end

 

  def destroy
    
    b_requests = BookingRequest.where(rider_id: current_user.userable.id)
    b_requests_id_array = b_requests.pluck(:id)

    unless b_requests_id_array.include?(params[:id])
      render json: { message: "You are not authorized to view this page"} , status: :forbidden
      return 
    end

    
    breq = BookingRequest.find(params[:id])

    if breq
      if breq.destroy
        render json: {message: "BookingRequest was successfully destroyed"} , status: :ok
        return 
      else
        render json: {error: breq.errors.full_messages} , status: :forbidden
        return 
      end
    else
      render json: "No BookingRequest found with id #{params[:id]}" , status: :not_found
      return 
    end
  end
    

  

  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      render json: {error: "You are not authorized to view this page."} , status: :forbidden
    end
  end


end
