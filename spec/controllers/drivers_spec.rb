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

        # context "when driver_user signed in with valid params" do
            
        #     it "renders show template" do
                

        #         sign_in driver_user

               
                
        #         get :show  , params: {id: driver.id}
        #         expect(:response).to render_template(:show)
        #     end
        # end

    end


    describe "get /drivers#edit" do

        context "when user not signed in" do
            it "redirects to login page" do
                get :edit
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            it "redirects to rider dashboard" do
                sign_in rider_user
                get :edit
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


        # context "when ddriver_user signed in with valid params" do
        #     it "renders edit template" do
        #         sign_in driver_user
        #         get :show , params: {id: driver_user.userable.id}
        #         expect(response).to render_template(:edit)
        #     end
        # end

    end

    describe "patch /drivers#update" do


        context "when user not signed in" do
            it "redirects to login page" do
                patch :update
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            it "redirects to rider dashboard" do
                sign_in rider_user
                patch :update
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in with valid params" do
            it "redirects to driver dashboard" do
                sign_in driver_user
                patch :update , params: {driver: {standby_city: "Trichy"}}
                expect(flash[:notice]).to eq("Your standing city changed successfully")
            end
        end
    end

    describe "get /drivers#dash" do

        context "when user not signed in" do
            it "redirects to login page" do
                get :dash
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            it "redirects to rider dashboard" do
                sign_in rider_user
                get :dash
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in" do
            it "renders dash template" do
                sign_in driver_user
                get :dash
                expect(response).to render_template(:dash)
            end
        end

    end

    describe "get /drivers#edit_standby_city" do

        context "when user not signed in" do
            it "redirects to login page" do
                get :edit_standby_city
                expect(response).to redirect_to(new_user_session_path)
            end
        end


        context "when rider_user signed in" do
            it "redirects to rider dashboard" do
                sign_in rider_user
                get :edit_standby_city
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in" do
            it "renders dash template" do
                sign_in driver_user
                get :edit_standby_city
                expect(response).to render_template(:edit_standby_city)
            end
        end

    end

    describe "get /drivers#rating_change" do

        context "when user not signed in" do
            it "redirects to login page" do
                get :rating_change
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver_user signed in" do
            it "redirects to driver dashboard page" do
                sign_in driver_user
                get :rating_change
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when driver signed in with valid params" do
            it "redirects to driver dashboard page" do
                sign_in driver_user
                get :rating_change , params: { driver: { id: 885}}
                expect(flash[:alert]).to eq("Unauthorized action")
            end
        end

        context "when rider_user signed in with valid params" do
            it "redirects to rider_dash_path" do
                sign_in rider_user
                get :rating_change , params: {driver: {id: 885}}
                expect(response).to redirect_to(rider_dash_path)
            end
        end

    end

    describe "get /drivers#available_ride" do

        context "when user not signed in" do
            it "redirects to login page" do
                get :available_ride
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when rider_user signed in" do
            it "redirects to rider_dash_path" do
                sign_in rider_user
                get :available_ride
                expect(response).to redirect_to(rider_dash_path)
            end
        end

        context "when driver_user signed in " do
            it "renders available_ride template" do
                sign_in driver_user
                get :available_ride
                expect(response).to render_template(:available_ride)
            end
        end

    end
    


end