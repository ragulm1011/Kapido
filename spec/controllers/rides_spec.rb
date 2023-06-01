require 'rails_helper'

RSpec.describe RidesController, type: :controller do
    
    let(:rider) { create(:rider) }
    let(:rider_user) { create(:user , :for_rider , userable: rider)}

    let(:driver) {  create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    let(:booking_request) { create(:booking_request , rider: rider) }

    let(:ride) { create(:ride , driver: driver , rider: rider , booking_request: booking_request)}

    let(:rider_2) { create(:rider) }
    let(:rider_user_2) { create(:user , :for_rider , userable: rider_2)}


    let(:payment) { create(:payment , rider: rider , driver: driver) }
    let(:bill) { create(:bill , ride: ride , payment: payment)}

    describe "get /rides#index" do

        context "when user is not signed in" do
            before do
                get :index
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user signed in" do
            before do
                sign_in rider_user
                get :index
            end
            it "renders index template" do
               
                expect(response).to render_template(:index)
            end
        end

        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :index
            end
            it "renders index template" do
                
                expect(response).to render_template(:index)
            end
        end

    end

    describe "get /rides#new"  do

        context "when user is not signed in" do
            before do
                get :new
            end
            it "redirects to login page" do
              
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user signed in" do
            before do
                sign_in rider_user
                get :new , params: {id: 1}
            end
            it "redirects to rider dashboard page" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :new , params: {id: 2844}
            end
            it "renders new template" do
               
                expect(flash[:notice]).to eq("You are on the ride")
            end
        end



    end

    describe "get /rides#waiting" do

        context "when user is not signed in" do
            before do
                get :waiting
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        
        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :waiting , params: {id: 1}
            end
            it "redirects to driver dashboard page" do
             
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

        context "when rider_user signed in with valid params" do
            before do
                sign_in rider_user
                get :waiting , params: {id: booking_request.id}
            end
            it "redirects to rider dashboard page" do
               
                expect(response).to render_template(:waiting)
            end
        end

        context "when rider_user signed in with invalid params" do
            before do
                sign_in rider_user_2
                get :waiting , params: {id: booking_request.id}
            end
            it "redirects to rider dashboard page" do
               
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

        context "when rider_user signed in with valid params and booking_status become booked" do
            before do
                sign_in rider_user
                booking_request.booking_status = "booked"
                booking_request.save

                get :waiting , params: { id: booking_request.id }
            end
            it "redirects to finish waiting page" do
               
                expect(flash[:notice]).to eq("Your waiting was over")
            end
        end

    end

    describe "get /rides#finish_waiting" do

        context "when user is not signed in" do
            before do
                get :waiting
            end
            it "redirects to login page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when driver_user is signed in" do
            before do
                sign_in driver_user
                get :finish_waiting
            end
            it "redirects to driver dashboard page" do
               
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

        context "when rider_user signed in " do
            before do
                sign_in rider_user
                get :finish_waiting , params: {bid: ride.booking_request.id}
            end
            it "redirects to riding page" do
               
                expect(flash[:notice]).to eq("You are moved to ride")
            end
        end

        



    end

    describe "get /rides#riding" do

        context "when user is not signed in" do
            before do
                get :riding
            end
            it "redirects to login page" do

                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user is signed in" do
            before do
                sign_in driver_user
                get :riding , params: {id: ride.id }
            end
            it "renders riding template" do
               
                expect(response).to render_template(:riding)
            end
        end

        
        # context "when rider_user signed in " do
        #     it "redirects to new payment page" do
        #         sign_in rider_user
        #         get :riding , params: {id: ride.id }
        #         expect(flash[:notice]).to eq("Ride ended successfully")
        #     end
        # end



    end

end