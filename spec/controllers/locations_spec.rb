require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
    

    let(:rider) { create(:rider)  }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    describe "get /locations#new" do

        context "when user not signed in" do
            it "redirects to login page" do
                get :new
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user signed in" do
            it "redirects to driver dashboard page" do
                sign_in driver_user
                get :new
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when rider_user signed in" do
            it "renders new template" do
                sign_in rider_user
                get :new
                expect(response).to render_template(:new)
            end
        end

    end

    
    describe "post /locations#create" do

        context "when user is not signed in" do
            it "redirects to login page" do
                post :create
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user is signed in" do
            it "redirects to driver dashboard page" do
                sign_in driver_user
                post :create
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when rider_user is signed in with invalid params" do
            it "redirects to new_booking_request_path" do
                sign_in rider_user
                post :create , params: {location: {location_name: "Sri Shakthi" ,landmark: "L&T" , city: nil , pincode: 641092 }}
                expect(response).to render_template(:new)
            end
        end

        context "when rider_user is signed in with valid params" do
            it "redirects to new_booking_request_path" do
                sign_in rider_user
                post :create , params: {location: {location_name: "Sri Shakthi" ,landmark: "L&T" , city: "Coimbatore" , pincode: 641092 }}
                expect(response).to redirect_to new_booking_request_path
            end
        end

    end

end