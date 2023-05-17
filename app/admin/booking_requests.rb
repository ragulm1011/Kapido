ActiveAdmin.register BookingRequest do
  permit_params :city, :booking_status, :vehicle_type, :from_location_id, :to_location_id, :rider_id, :from_location_name, :to_location_name

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:city, :booking_status, :vehicle_type, :from_location_id, :to_location_id, :rider_id, :from_location_name, :to_location_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do

    column "BookingRequestID" , :id do |i|
      link_to i.id , admin_booking_request_path(i.id)
    end

    column "City" , :city

    column "BookingStatus" , :booking_status

    column "VehicleType" , :vehicle_type

    column "Rider Name" , :rider_id do |i|
      rider = Rider.find(i.rider_id)
      link_to rider.user.name , admin_user_path(rider.user.id)
    end

    column "From" , :from_location_name

    column "To" , :to_location_name 

  end



  scope :all
  scope :available_requests
  scope :booked_requests

  filter :city
  
  filter :rider_id

  #Custom Filters
  filter :vehicle_type , as: :select , collection: BookingRequest.all.map(&:vehicle_type).sort.uniq
  filter :from_location_name , as: :select , collection: BookingRequest.all.map(&:from_location_name).sort.uniq
  filter :to_location_name , as: :select , collection: BookingRequest.all.map(&:to_location_name).sort.uniq
    
  end

  
  
  

