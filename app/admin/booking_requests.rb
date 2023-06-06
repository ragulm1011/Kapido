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
    

  form do |f|
    f.semantic_errors
  
    f.inputs do
      f.input :rider , as: :select , collection: Rider.all.collect{|rider| [rider.user.name , rider.id]}
      f.input :city
      f.input :booking_status , as: :select , collection: [['available','available'] , ['booked','booked']]

      




      f.input :vehicle_type , as: :select , collection: ["Bike" ,"Auto" ,  "Mini-Car" , "Sedan-Car" , "SUV-Car"]
      f.input :from_location_name
      f.input :to_location_name
    end
    f.actions
  end
end

  
# form do |f|
#       f.semantic_errors
#       f.inputs
#       f.inputs do
#         f.has_many :user, heading: 'Account Details', allow_destroy: true do |a|
#           a.input :email
#           a.input :password
#           a.input :password_confirmation
#           a.input :role, as: :select, collection: %w[student teacher]
#         end
#       end
#       f.actions
#     end
  
  
# filter :primary_vehicle_id , as: :select , collection: Vehicle.all.map{|vehicle| [vehicle.vehicle_name , vehicle.id]}
  
  

