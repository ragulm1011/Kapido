ActiveAdmin.register User do
  
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :name, :age, :mobile_no, :userable_id, :userable_type, :role, :door_no, :street, :city, :district, :state, :pincode
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :name, :age, :mobile_no, :userable_id, :userable_type, :role, :door_no, :street, :city, :district, :state, :pincode]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do

    column "User ID" , :id do |i|
      link_to i.id , admin_user_path(i.id)
    end

    column "Email" , :email

    column "Name" , :name

    column "Age" , :age

    column "Mobile No" , :mobile_no

    column "Role" , :role

    column "Door No" , :door_no

    column "Street" , :street

    column "City" , :city

    column "District" , :district

    column "State" , :state

    column "Pincode" , :pincode

  end


  filter :name
  filter :age
  filter :role

  #Custom Filters
  filter :city ,  :as => :select, :collection => User.all.map(&:city).uniq
  filter :district ,  :as => :select, :collection => User.all.map(&:district).uniq
  filter :state ,  :as => :select, :collection => User.all.map(&:state).uniq

  
  filter :pincode


  scope :all

end
