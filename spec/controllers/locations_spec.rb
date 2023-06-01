require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
    

    let(:rider) { create(:rider)  }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    describe "get /locations#new" do

        context "when user not signed in" do
            before do
                get :new
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :new
            end
            it "redirects to driver dashboard page" do
                
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when rider_user signed in" do
            before do   
                sign_in rider_user
                get :new 
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end
        end

    end

    
    describe "post /locations#create" do

        context "when user is not signed in" do
            before do   
                post :create
            end
            it "redirects to login page" do
              
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user is signed in" do
            before do   
                sign_in driver_user
                post :create
            end
            it "redirects to driver dashboard page" do
              
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when rider_user is signed in with invalid params" do
            before do   
                sign_in rider_user
                post :create , params: {location: {location_name: "Sri Shakthi" ,landmark: "L&T" , city: nil , pincode: 641092 }}
            end
            it "redirects to new_booking_request_path" do
                
                expect(response).to render_template(:new)
            end
        end

        context "when rider_user is signed in with valid params" do
            before do   
                sign_in rider_user
                post :create , params: {location: {location_name: "Sri Shakthi" ,landmark: "L&T" , city: "Coimbatore" , pincode: 641092 }}
            end
            it "redirects to new_booking_request_path" do
               
                expect(response).to redirect_to new_booking_request_path
            end
        end

    end

end