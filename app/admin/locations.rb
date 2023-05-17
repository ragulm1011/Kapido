ActiveAdmin.register Location do

  
  permit_params :location_name, :landmark, :city, :pincode, :rider_id
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:location_name, :landmark, :city, :pincode, :rider_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do

    column "LocationID" , :id do |i|
      link_to i.id , admin_location_path(i.id)
    end

    column "Location Name" , :location_name
    column "Landmark" , :landmark
    column "City" , :city
    column "Pincode" , :pincode
    

    column "RiderID" , :rider_id do |i|
      unless i.rider_id == 3
        rider = Rider.find(i.rider_id)
        link_to "Location of " + rider.user.name  , admin_user_path(rider.user.id)
      else
          "Default Location"
      end
    end

  end


  scope :all
  scope :default_locations
  scope :riders_locations

  filter :location_name
  filter :landmark

  #Custom filter
  filter :city , as: :select , collection: Location.all.map(&:location_name).uniq

  filter :pincode
  # filter :rider_id 



end
