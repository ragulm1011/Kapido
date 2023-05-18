class Api::BookingRequestsController < Api::ApiController
  
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index 
    @breqs = BookingRequest.all
    
    if @breqs.empty?
      render json: "No BookingRequests found" , status: :no_content
    else
      render json: @breqs, status: :ok
    end

  end


  def show 
    @breq = BookingRequest.find(params[:id])
    if @breq
      render json: @breq, status: :ok
    else
      render json: "No BookingRequest found with id #{params[:id]}" , status: :not_found
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

    bookingRequest.rider_id = params[:rider_id]
    


    if  bookingRequest.save
      render json: bookingRequest , status: :created
    else
      render json: {  errors: bookingRequest.errors.full_messages } , status: :unprocessable_entity
    end

  end

  def update 
    @breq = BookingRequest.find(params[:id])
    @updatedCity = params[:city]
    if @breq
      @breq.city = @updatedCity
      if @breq.save
        render json: @breq, status: :accpeted
      else
        render json: { error: @breq.errors.full_messages} , status: :unprocessable_entity
      end
    else
      render json: "No BookingRequest found" , status: :not_found
    end
  end

 

  def destroy
    
    @breq = BookingRequest.find(params[:id])
    if @breq
      if @breq.destroy
        render json: {message: "BookingRequest was successfully destroyed"} , status: :ok
      else
        render json: {error: @breq.errors.full_messages} , status: :forbidden
      end
    else
      render json: "No BookingRequest found with id #{params[:id]}" , status: :not_found
    end
  end
    

  private
  def create_params
    params.require(:booking_request).permit(:city, :vehicle_type , :from_location_name , :to_location_name)
  end

end
