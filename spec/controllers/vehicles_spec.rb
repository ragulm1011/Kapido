require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do

    let(:rider) { create(:rider) }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    let(:vehicle) { create(:vehicle) }
    
    describe "get /vehicles#new" do
        
        context "when user is not signed in" do
            it "redirects to login page" do
                get :new
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            it "redirects to rider dashboard page" do
                sign_in rider_user
                get :new
                expect(response).to redirect_to(rider_dash_path)
            end
        end
        
        context "when driver_user signed in"   do
            it "renders new template" do
                sign_in driver_user
                get :new
                expect(response).to render_template(:new)
            end

        end

    end

    describe "post /vehicles#create" do

        context "when user is not signed in" do
            it "redircts to login page" do
                post :create
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            it "redirects to rider dashboard page"  do
                sign_in rider_user
                post :create
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user is signed in with valid params" do
            it  "redirects to driver dashboard page" do
                sign_in driver_user
                post :create , params: {vehicle: {vehicle_name: "TVS" , vehicle_type: "Bike" , no_of_seats: 1 , vehicle_no: "TN02AV0253"}}
                expect(flash[:notice]).to eq("Your Vehicle added successfully")
            end
        end

        context "when driver_user is signed in with invalid params" do
            it "renders the new template again" do
                sign_in driver_user
                post :create , params: {vehicle: {vehicle_name: nil , vehicle_type: "Bike" , no_of_seats: 1 , vehicle_no: "TN02AV0253"}}
                expect(response).to render_template(:new)
            end
        end

    end

    describe "get /vehicles#change_primary_vehcile" do

        context "when user is not signed in" do
            it "redircts to login page" do
                get :change_primary_vehicle
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            it "redirects to rider dashboard page"  do
                sign_in rider_user
                get :change_primary_vehicle
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user is signed in" do
            it "renders the change primary vehicle template" do
                sign_in driver_user
                get :change_primary_vehicle
                expect(response).to render_template(:change_primary_vehicle)
            end
        end

    end


    describe "get /vehicles#set_primary_vehicle" do

        context "when user is not signed in" do
            it "redircts to login page" do
                get :set_primary_vehicle
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            it "redirects to rider dashboard page"  do
                sign_in rider_user
                get :set_primary_vehicle
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in with valid vehicle id" do
            it "redirects to driver dashboard page" do
                sign_in driver_user

                vehicle.driver_no = driver.id
                vehicle.save

                get :set_primary_vehicle , params: {id: vehicle.id}
                expect(response).to redirect_to(driver_dash_path)
                
            end
        end

        context "when driver_user signed in with invalid vehicle id" do
            it "flashes an unauthorized action message" do
                sign_in driver_user
                get :set_primary_vehicle , params: {id: 1000}
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

    end
    
end