require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
    
    let(:rider) { create(:rider) }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    describe "get /payments#new" do

        context "when user is not signed in" do
            before do
                get :new
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in with valid params" do
            before do
                sign_in rider_user
                get :new , params: { rideId: 1 }
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end
        end

        context "when driver_user is signed in with valid params" do
            before do
                sign_in driver_user
                get :new , params: { rideId: 1 }
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end
        end

    end

    describe "post /payments#create" do
        
        context "when user is not signed in" do
            before do

            end
            it "redirects to login page" do
                post :create , params: { payment: {rider_id: 1 , driver_id: 1 , mode_of_payment: "Gpay" , amount: 100 , credentials: "9994406107" , remarks: "Done for a ride" , bill_no: 1}}
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in with valid params" do
            before do
                sign_in rider_user
                post :create , params: { payment: {rider_id: 6146 , driver_id: 4575 , mode_of_payment: "Gpay" , amount: 100 , credentials: "9994406107" , remarks: "Done for a ride" , bill_no: 1}}
            end
            it "redirects to successful path" do
                
                expect(flash[:notice]).to eq("Payment done successfully")
            end
        end

        context "when rider_user is signed in with invalid params" do
            before do
                sign_in rider_user
                post :create , params: { payment: {rider_id: 1 , driver_id: 1 , mode_of_payment: nil , amount: 100 , credentials: "9994406107" , remarks: "Done for a ride" , bill_no: 1}}
            end
            it "renders new template" do
                
                expect(response).to render_template(:new)
            end
        end

        context "when driver_user is signed in with valid params" do
            before do
                sign_in driver_user
                post :create , params: { payment: {rider_id: 6585 , driver_id: 4575 , mode_of_payment: "Gpay" , amount: 100 , credentials: "9994406107" , remarks: "Done for a ride" , bill_no: 1}}
            end
            it "redirects to successful path" do
              
                expect(flash[:notice]).to eq("Payment done successfully")
            end
        end

        context "when driver_user is signed in with invalid params" do
            before do
                sign_in driver_user
                post :create , params: { payment: {rider_id: 1 , driver_id: 1 , mode_of_payment: nil , amount: 100 , credentials: "9994406107" , remarks: "Done for a ride" , bill_no: 1}}
            end
            it "renders new template" do
               
                expect(response).to render_template(:new)
            end
        end


    end

    describe "get /payments#waiting_payment" do

        context "when user is not signed in" do
            before do
                get :waiting_payment
            end
            it "redirects to login page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            before do
                sign_in rider_user
                get :waiting_payment , params: {billId: 415 }
            end
            it "redirects to successful path" do
                
                expect(response).to redirect_to(successful_path)
            end
        end

        context "when driver_user is signed in" do
            before do
                sign_in driver_user
                get :waiting_payment , params: { billId: 415 }
            end
            it "redirects to successful path" do
                
                expect(response).to redirect_to(successful_path)
            end
        end

    end

    describe "get /payments#successful_payment" do
        
        context "when user is not signed in" do
            before do
                get :successful
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user is signed in" do
            before do
                sign_in rider_user , ''
                get :successful , params: { paymentId: 1}
            end
            it "renders successful template" do
               
                expect(response).to render_template(:successful)
            end
        end

        context "when driver_user is signed in" do
            before do
                sign_in driver_user
                get :successful
            end
            it "renders successful template" do
                
                expect(response).to render_template(:successful)
            end
        end

    end



end