ActiveAdmin.register Driver do
  
  permit_params :liscense_no, :driver_rating, :standby_city, :primary_vehicle_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:liscense_no, :driver_rating, :standby_city, :primary_vehicle_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do 
    
    column "DriverID" , :id do |i|
      link_to i.id , admin_driver_path(i.id)
    end

    column "Name" , :id do |i|
      if i.user
        link_to i.user.name , admin_user_path(i.user.id)
      else
        "No name given"
      end

    end

    column "Liscense Number" , :liscense_no

    column "Driver Rating" , :driver_rating

    column "Standing City" , :standby_city

    column "Primary Vehicle Name" , :primary_vehicle_id do |i|
      if i.primary_vehicle_id
        vehicle = Vehicle.find(i.primary_vehicle_id)
        link_to vehicle.vehicle_name , admin_vehicle_path(vehicle.id)
      else
        "No primary vehicle available"
      end


    end

  end



  scope :all
  scope :rating_less_than_3
  scope :rating_greater_than_3



  filter :liscense_no
  filter :driver_rating
  filter :standby_city

  
  

end
  
