ActiveAdmin.register Payment do
  
  permit_params :rider_id, :driver_id, :mode_of_payment, :amount, :credentials, :remarks, :payment_date, :bill_no

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:rider_id, :driver_id, :mode_of_payment, :amount, :credentials, :remarks, :payment_date, :bill_no]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do 

    column "PaymentID" , :id do |i|
      link_to i.id , admin_payment_path(i.id)
    end

    column "RiderID" , :rider_id do |i|
      rider = Rider.find(i.rider_id)
      link_to rider.user.name , admin_user_path(rider.user.id)
    end

    column "DriverID" , :driver_id do |i|
      driver = Driver.find(i.driver_id)
      link_to driver.user.name , admin_user_path(driver.user.id)
    end

    column "Mode Of Payment" , :mode_of_payment

    column "Amount" , :amount

    column "Credentials" , :credentials do |i|
      if i.credentials.present?
        i.credentials
      else
        "No credentials found"
      end
    end
    
    column "Remarks" , :remarks do |i|
      if i.remarks.present?
        i.remarks
      else
        "No remarks found"
      end
    end

    column "Payment Date" , :payment_date do |i|
      if i.payment_date.present?
        i.payment_date
      else
        "No payment date found"
      end
    end
end


  filter :rider_id
  filter :driver_id

  #Custom Filter
  filter :mode_of_payment , as: :select , collection: [['Gpay','Gpay'] , ['PhonePe','PhonePe'] , ['Paytm','Paytm']]


  filter :amount
  filter :payment_date


  scope :all

  
end
