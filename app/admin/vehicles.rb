ActiveAdmin.register Vehicle do

  permit_params :vehicle_name, :vehicle_type, :no_of_seats, :vehicle_no, :driver_no
 
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:vehicle_name, :vehicle_type, :no_of_seats, :vehicle_no, :driver_no]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do

    column "Vehicle ID" , :id do |i|
      link_to i.id , admin_vehicle_path(i.id)
    end

    column "Vehicle Name" , :vehicle_name

    column "Vehicle Type" , :vehicle_type

    column "No of Seats" , :no_of_seats

    column "Vehicle Number" , :vehicle_no

    actions

  end


  #Custom filter
  filter :vehicle_name , :as => :select, :collection => Vehicle.all.map(&:vehicle_name)


  filter :vehicle_type
  filter :no_of_seats
  filter :vehicle_no

  scope :all


  
end
