require 'rails_helper'

RSpec.describe BookingRequestsController, type: :controller do


    
    let!(:rider) { create(:rider) }
    let!(:rider_user) { create(:user , :for_rider , userable: rider)}
    
    let!(:driver_user) { create(:user , :for_driver) }

    let!(:booking_request) { create(:booking_request , rider: rider) }

    let!(:location) { create(:location , rider: rider)}
    
    
    
    describe "get /booking_requests#new" do

        context "when user not signed in" do
            before do   
                get :new
            end
            it "redirects to sign in page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user signed in" do
            before do   
                sign_in driver_user
                get :new
            end
            it "redirects to sign in page" do
               
                expect(response).to redirect_to (driver_dash_path)
            end
        end

        context "when rider_user signed in" do
            before do   
                sign_in rider_user
                get :new
            end
            it "renders new template" do
               
                expect(response).to render_template :new
            end
        end
       
        
      end


      describe "post /booking_requests#create" do

        context "when user not signed in" do
            let!(:location_1) { create(:location , rider: rider)}
            before do   
                post :create ,  params:{ booking_request:{ from_location_name: "Peelamedu" , to_location_name: "Peelamedu" , city: "Coimbatore" , vehicle_type: "Sedan-Car"} } 
            end
           
            it "redirects to sign in page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user signed in" do
            
            let!(:location_2) { create(:location , rider: rider)}
            before do   
                sign_in driver_user
                post :create , params:{ booking_request:{ from_location_name: "Peelamedu" , to_location_name: "Peelamedu" , city: "Coimbatore" , vehicle_type: "Sedan-Car"} }
            end
            
            it "redirects to driver dashboard" do
               
                expect(response).to redirect_to (driver_dash_path)
            end
        end

        context "when rider_user signed in and given valid params" do
           
            let!(:location_1) { create(:location , rider: rider)}
            before do   
                sign_in rider_user
                post :create , params:{ booking_request:{ from_location_name: "Peelamedu" , to_location_name: "Peelamedu" , city: "Coimbatore" , vehicle_type: "Sedan-Car"} }
            end
            it "redirects to waiting page" do
               
                expect(flash[:notice]).to eq("Your booking was created and wait for driver to accept the request")
            end
        end

        context "when rider_user signed in and given invalid params" do
            before do   
                sign_in rider_user
                post :create , params:{ booking_request:{ from_location_name: "Peelamedu" , to_location_name: "Peelamedu" , city: nil , vehicle_type: "Sedan-Car"} }
            end
            it "renders new template" do
                
                expect(response).to render_template (:new)
            end
        end


      end


      describe "delete /booking_requests#destroy" do

        context "when user not signed in" do
            before do   
                delete :destroy ,  params:{ bid: booking_request.id }
            end
            it "redirects to sign in page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user signed in" do
            before do   
                sign_in driver_user
                delete :destroy , params:{ bid: booking_request.id }
            end
            it "redirects to driver dashboard" do
                
                expect(response).to redirect_to (driver_dash_path)
            end
        end

        context "when the owner rider_user signed in" do
            before do   
                sign_in rider_user
                delete :destroy , params:{ bid: booking_request.id }
            end
            it "redirects to rider dashboard" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when any other rider_user signed in" do
            before do   
                rider1 = create(:user , :for_rider)
                sign_in rider1
                delete :destroy , params:{ bid: booking_request.id }
            end
            it "redirects to rider dashboard" do
               
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end


      end

end