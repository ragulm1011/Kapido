require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do

    let(:rider) { create(:rider) }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    let(:vehicle) { create(:vehicle) }
    
    describe "get /vehicles#new" do
        
        context "when user is not signed in" do
            before do
                get :new
            end
            it "redirects to login page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            before do
                sign_in rider_user
                get :new
            end
            it "redirects to rider dashboard page" do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end
        
        context "when driver_user signed in"   do
            before do
                sign_in driver_user
                get :new
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end

        end

    end

    describe "post /vehicles#create" do

        context "when user is not signed in" do
            before do
                post :create
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            before do
                sign_in rider_user
                post :create
            end
            it "redirects to rider dashboard page"  do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user is signed in with valid params" do
            before do
                sign_in driver_user
                post :create , params: {vehicle: {vehicle_name: "TVS" , vehicle_type: "Bike" , no_of_seats: 1 , vehicle_no: "TN02AV0253"}}
            end
            it  "redirects to driver dashboard page" do
                
                expect(flash[:notice]).to eq("Your Vehicle added successfully")
            end
        end

        context "when driver_user is signed in with invalid params" do
            before do
                sign_in driver_user
                post :create , params: {vehicle: {vehicle_name: nil , vehicle_type: "Bike" , no_of_seats: 1 , vehicle_no: "TN02AV0253"}}
            end
            it "renders the new template again" do
               
                expect(response).to render_template(:new)
            end
        end

    end

    describe "get /vehicles#change_primary_vehcile" do

        context "when user is not signed in" do
            before do
                get :change_primary_vehicle
            end
            it "redircts to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            before do
                sign_in rider_user
                get :change_primary_vehicle
            end
            it "redirects to rider dashboard page"  do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user is signed in" do
            before do
                sign_in driver_user
                get :change_primary_vehicle
            end
            it "renders the change primary vehicle template" do
                
                expect(response).to render_template(:change_primary_vehicle)
            end
        end

    end


    describe "get /vehicles#set_primary_vehicle" do

        context "when user is not signed in" do
            before do
                get :set_primary_vehicle
            end
            it "redircts to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            before do
                sign_in rider_user
                get :set_primary_vehicle
            end
            it "redirects to rider dashboard page"  do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in with valid vehicle id" do
            before do
                sign_in driver_user

                vehicle.driver_no = driver.id
                vehicle.save

                get :set_primary_vehicle , params: {id: vehicle.id}
            end
            it "redirects to driver dashboard page" do
                
                expect(response).to redirect_to(driver_dash_path)
                
            end
        end

        context "when driver_user signed in with invalid vehicle id" do
            before do
                sign_in driver_user
                get :set_primary_vehicle , params: {id: 1000}
            end
            it "flashes an unauthorized action message" do
                
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

    end
    
end