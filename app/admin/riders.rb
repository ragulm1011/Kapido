ActiveAdmin.register Rider do

  permit_params :gender, :aadhar_no

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:gender, :aadhar_no]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do 

    column "RiderID" , :id do |i|
      link_to i.id , admin_rider_path(i.id)
    end

    column "Name" , :id do |i|
      link_to i.user.name , admin_user_path(i.user.id)
    end

    column "Age" , :id do |i|
      i.user.age
    end

    column "Gender" , :gender

    column "Aadhar No" , :aadhar_no

  end

  


  scope :all
  scope :made_rides
  scope :does_not_made_rides

  #Custom Filter
  filter :gender , :as => :select , :collection => [['Male','Male'] , ['Female','Female']]
  
  
end
