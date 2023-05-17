ActiveAdmin.register Ride do
  permit_params :rider_id, :driver_id, :booking_request_id, :ride_date, :ride_status

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:rider_id, :driver_id, :booking_request_id, :ride_date, :ride_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do

    column "RideID" , :id do |i|
      link_to i.id , admin_ride_path(i.id)
    end

    

    column "Rider Name" , :rider_id do |i|
      link_to i.rider.user.name , admin_rider_path(i.rider_id)
    end

    column "Driver Name" , :driver_id do |i|
      link_to i.driver.user.name , admin_driver_path(i.driver_id)
    end

    column "BookingRequestID" , :booking_request_id do |i|
      link_to i.booking_request_id , admin_booking_request_path(i.booking_request_id)
    end

   
    column "Ride Date" , :ride_date

  end



  filter :ride_date

  #Custom Filter
  filter :rider_id , :as => :select , :collection => Ride.all.map(&:rider_id).uniq
  filter :driver_id , :as => :select , :colection => Ride.all.map(&:driver_id).uniq

  scope :all
  
end