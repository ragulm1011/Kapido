ActiveAdmin.register Bill do
  
  permit_params :ride_id, :payment_id, :bill_date, :bill_amount
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:ride_id, :payment_id, :bill_date, :bill_amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do

    column "BillID" , :id do |i|
      link_to i.id , admin_bill_path(i.id)
    end
    
    column "Ride ID" , :ride_id do |i|
      link_to i.ride_id , admin_ride_path(i.ride_id)
    end
    
    column "Payment ID" , :payment_id do |i|
      link_to i.payment_id , admin_payment_path(i.payment_id)
    end

    column "Sender" , :ride_id do |i|
      ride = Ride.find(i.ride_id)
      rider = Rider.find(ride.rider_id)
      link_to rider.user.name , admin_user_path(rider.user.id)
    end

    column "Reciever" , :ride_id do |i|
      ride = Ride.find(i.ride_id)
      driver = Driver.find(ride.driver_id)
      if driver.user
        link_to driver.user.name , admin_user_path(driver.user.id)
      else
        "No Reciever Name Available"
      end
    end

    column :bill_date
    column :bill_amount

  end

  scope :all
  scope :bill_amount_less_than_50
  scope :bill_amount_greater_than_50

  filter :bill_date
  filter :bill_amount
  
  
end
