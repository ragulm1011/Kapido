require 'rails_helper'

RSpec.describe BillsController, type: :controller do

    let(:rider) { create(:rider) }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver)}

    let(:driver_1) { create(:driver)}
    let(:driver_user_1) { create(:user , :for_driver , userable: driver_1)}

    let(:booking_request) { create(:booking_request , rider: rider) }

    let(:ride) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}

    describe "get /bills#new" do


        context "when user not signed in" do
            before do  
                get :new
            end
            it "redirects to sign in page" do
               
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

        context "when driver_user and the ride creator signed in" do
            before do  
                sign_in driver_user
                get :new , params: {rideId: ride.id}
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end
        end

        context "when driver_user and not the ride creator signed in" do
            before do  
                sign_in driver_user_1
                get :new , params: { rideId: ride.id}
            end
            it "redirects to driver dashboard page" do
                
                expect(response).to redirect_to(driver_dash_path)
            end
        end


    end

    describe "post /bills#create" do

        context "when user not signed in" do
            before do  
                post :create , params: {bill: {ride_id: ride.id , bill_amount: 500}}
            end
            it "redirects to sign in page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in with valid params" do
            before do  
                sign_in rider_user
                post :create , params: {bill: {ride_id: ride.id , bill_amount: 500}}
            end
            it "redirects to rider dashboard page" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when rider_user is signed in with invalid params" do
            before do  
                sign_in rider_user
                post :create , params: {bill: {ride_id: ride.id , bill_amount: nil}}
            end
            it "redirects to rider dashboard page" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        # Add 25 payment records and uncomment it
        # context "when driver_user is signed in with valid params" do
        #     it "redirects to waiting payment path" do
        #         sign_in driver_user
        #         post :create , params: {bill: {ride_id: ride.id , bill_amount: 500}}
        #         expect(flash[:notice]).to eq("Your bill was created and wait for the payment")
        #     end
        # end

        context "when driver_user is signed in with invalid params" do
            before do  
                sign_in driver_user_1
                post :create , params: {bill: {ride_id: ride.id , bill_amount: nil}}
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end
        end


    end


    
end