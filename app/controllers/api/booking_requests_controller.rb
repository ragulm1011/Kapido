class Api::BookingRequestsController < Api::ApiController
  
  # before_action :authenticate_user!
  before_action :is_rider? , except: [:index , :show , :own_index]


  def index 

    breqs = BookingRequest.all
    if breqs.empty?
      render json: { message: "No booking requests found." } , status: :no_content
    else
      render json: breqs , status: :ok
    end

  end


  def show 

    if current_user.rider?
      render json: {message: "You are not authorized to view this page "} , status: :forbidden
      return       
    end


    b_req = BookingRequest.find_by(id: params[:id].to_i)
    if b_req
      if b_req.city = current_user.userable.standby_city
        render json: b_req , status: :ok
      else
        render json: { message: "You are not authorized to view this page" } , status: :forbidden
      end
    else
      render json: { message: "No Booking Request found with the id #{params[:id].to_i}" } , status: :not_found
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

    breq = BookingRequest.find_by(id: params[:id])
    if breq
      if breq.rider_id == current_user.userable.id
        breq.city = params[:city]
        if breq.save
          render json: breq , status: :ok
        else
          render json: { errors: breq.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page"} , status: :forbidden
      end
    else
      render json: { message: "No booking request found with this id #{params[:id].to_i}"} , status: :not_found
    end

    
  end

 

  def destroy
    
    breq = BookingRequest.find_by(id: params[:id].to_i)
    if breq
      if breq.rider_id == current_user.userable.id 
        if breq.destroy
          render json: { message: "BookingRequest was successfully destroyed"} , status: :ok
        else
          render json: { errors: breq.errors.full_messages } , status: :unprocessable_entity
        end
      else
        render json: { message: "You are not authorized to view this page"} , status: :forbidden
      end
    else
      render json: {message: "No booking request found with the id #{params[:id].to_i}"} , status: :not_found
    end
  end



  def your_booking_requests
    
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
    

  

  private
  def is_rider?
    unless user_signed_in? && current_user.rider?
      render json: {error: "You are not authorized to view this page."} , status: :forbidden
    end
  end


end
