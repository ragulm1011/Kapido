require 'rails_helper'

RSpec.describe DriversController, type: :controller do
    
    let(:rider) { create(:rider)}
    let(:rider_user) { create(:user , :for_rider , userable: rider)}

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }


    let(:driver_1) { create(:driver) }
    let(:driver_user_1) { (create(:user , :for_driver , userable: driver_1))}



    describe "get /drivers#show" do

        context "when user not signed in" do

            it "redirects to login page" do
                get :show
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do

            it "redirects to rider dashboard" do
                sign_in rider_user
                get :show
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in with invalid params" do

            it "redirects to driver dashboard" do
                sign_in driver_user
                get :show , params: {id: driver_1.id}
                expect(response).to redirect_to(driver_dash_path)
            end
        end

   

    end


    describe "get /drivers#edit" do

        context "when user not signed in" do
            before do
                get :edit
            end
            it "redirects to login page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            before do
                sign_in rider_user
                get :edit
            end

            it "redirects to rider dashboard" do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in with invalid params" do
            before do
                sign_in driver_user
                get :show , params: {id: driver_1.id}
            end

            it "redirects to driver dashboard" do
                
                expect(response).to redirect_to(driver_dash_path)
            end
        end


       
    end

    describe "patch /drivers#update" do


        context "when user not signed in" do
            before do
                patch :update
            end

            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            before do
                sign_in rider_user
                patch :update
            end
            

            it "redirects to rider dashboard" do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in with valid params" do
            before do
                sign_in driver_user
                patch :update , params: {driver: {standby_city: "Trichy"}}
            end
            

            it "redirects to driver dashboard" do
               
                expect(flash[:notice]).to eq("Your standing city changed successfully")
            end
        end
    end

    describe "get /drivers#dash" do

        context "when user not signed in" do
            before do
                get :dash
            end
            it "redirects to login page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            before do
                sign_in rider_user
                get :dash
            end
            it "redirects to rider dashboard" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :dash
            end
            it "renders dash template" do
                
                expect(response).to render_template(:dash)
            end
        end

    end

    describe "get /drivers#edit_standby_city" do

        context "when user not signed in" do
            before do
                get :edit_standby_city
            end
            it "redirects to login page" do
                
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            before do
                sign_in rider_user
                get :edit_standby_city
            end

            it "redirects to rider dashboard" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :edit_standby_city
            end

            it "renders dash template" do
               
                expect(response).to render_template(:edit_standby_city)
            end
        end

    end

    describe "get /drivers#rating_change" do

        context "when user not signed in" do
            before do
                get :rating_change
                expect(response).to redirect_to(new_user_session_path)
            end
            it "redirects to login page" do
                
            end
        end

        context "when driver_user signed in" do
            before do
                sign_in driver_user
                get :rating_change
            end
            it "redirects to driver dashboard page" do
               
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when driver signed in with valid params" do
            before do
                sign_in driver_user
                get :rating_change , params: { driver: { id: 885}}
            end
            it "redirects to driver dashboard page" do
                
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

        context "when rider_user signed in with valid params" do
            let(:payment_100) { create(:payment) }
            before do
                sign_in rider_user
                get :rating_change , params: {driver: {id: payment_100.id}}
            end
            it "redirects to rider_dash_path" do
                
                expect(response).to redirect_to(rider_dash_path)
            end
        end

    end

    describe "get /drivers#available_ride" do

        context "when user not signed in" do
            before do
                get :available_ride
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user signed in" do
            before do
                sign_in rider_user
                get :available_ride
            end
            it "redirects to rider_dash_path" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in " do
            before do
                sign_in driver_user
                get :available_ride
            end

            it "renders available_ride template" do
                
                expect(response).to render_template(:available_ride)
            end
        end

    end
    


end