# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # address = Address.new(address_params)
    # user = User.new(userable_params);
    # if (params[:user][:role] == "Driver")
    #   driver = Driver.create(liscense_no: params[:driver_details][:liscense_no] , driver_rating: 5.0)
    #   user.userable_type = "Driver"
    #   user.userable_id = driver.id;
    #   address.addressable_id = driver.id 
    #   address.addressable_type = "Driver"
    #   vehicle = Vehicle.create(vehicle_params);
    #   vehicle.save 
    #   driver.vehicles << vehicle
    # else 
    #   rider = Rider.create(rider_params)
    #   user.userable_type = "Rider"
    #   user.userable_id = rider.id 
    #   address.addressable_type = "Rider" 
    #   address.addressable_id = rider.id 
    # end

    # address.save
    # user.save
    
    userable = if params[:user][:role] == 'Driver'
                    Driver.new(driver_params)

                    
                  else
                    Rider.new(rider_params)
                    
                    
                  end
                 
                  
    if params[:user][:role] == 'Driver'
      userable.driver_rating = 5.0
    end
    userable.save
    
    build_resource(sign_up_params)
    
    resource.name = params[:details][:name]
    resource.age = params[:details][:age]
    resource.mobile_no = params[:details][:mobile_no]
    resource.userable_id = userable.id
    resource.role = params[:user][:role]
    resource.userable_type = params[:user][:role].camelcase

    #  params.require(:address).permit(:door_no , :street, :city , :district , :state , :pincode)

    resource.door_no = params[:address][:door_no]
    resource.street = params[:address][:street]
    resource.city = params[:address][:city]
    resource.district = params[:address][:district]
    resource.state = params[:address][:state]
    resource.pincode = params[:address][:pincode]

    resource.save

      if params[:user][:role] == 'Rider'
        userable.aadhar_card_image.attach(params[:rider_details][:aadhar_card_image])
        userable.save

      end

      if params[:user][:role] == 'Driver'
        @vehicle = Vehicle.new(vehicle_params)
        @vehicle.driver_no = userable.id
        userable.vehicles << @vehicle
        userable.driver_rating = 5
        userable.liscense_image.attach(params[:user][:liscense_image])        
        userable.save
      end

     
    


    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    
              
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private 
  def address_params
    params.require(:address).permit(:door_no , :street, :city , :district , :state , :pincode)
  end


  private
  def userable_params 
    params.require(:user).permit(:name , :age  , :mobile_no , :role)
  end

  private
  def driver_params
    params.require(:driver_details).permit(:liscense_no)
  end

  private
  def rider_params
    params.require(:rider_details).permit(:gender , :aadhar_no)
  end

  private 
  def vehicle_params
    params.require(:vehicle_details).permit(:vehicle_name , :vehicle_type , :no_of_seats , :vehicle_no)
  end
end
