require 'rails_helper'

RSpec.describe RidersController, type: :controller do
    
    let(:rider) { create(:rider) }
    let(:rider_user) { create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    let(:rider_1) { create(:rider) }
    let(:rider_user_1) { create(:user , :for_rider , userable: rider_1) } 

    describe "get /riders#show" do

        context "when user is not signed in" do
            before do
                get :show
            end
            it "redirects to login page" do
               
                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver user is signed in" do
            before do
                sign_in driver_user
                get :show
            end
            it "redirects to driver dashboard page" do
                
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when rider signed in with invalid params" do
            before do
                sign_in rider_user
                get :show , params: { id: rider_user_1.userable.id}
            end
            it "redirects to rider dashboard page" do
               
                expect(response).to redirect_to(rider_dash_path)
            end
        end

    #     context "when rider signed in with valid params" do
    #         it "renders the show template" do
    #             sign_in rider_user
    #             get :show , params: { id: rider_user.userable.id}
    #             expect(response).to render_template(:show)
    #         end
    #     end
        
    end

    describe "get /riders#dash" do
        context "when user is not signed in" do
            before do
                get :dash
            end
            it "redirects to login page" do

                expect(response).to redirect_to(new_user_session_path)
            end
        end

        context "when driver user is signed in" do
            before do
                sign_in driver_user
                get :dash
            end
            it "redirects to driver dashboard page" do
               
                expect(response).to redirect_to(driver_dash_path)
            end
        end

        context "when rider user is signed in" do
            before do
                sign_in rider_user
                get :dash
            end
            it "renders dash template" do
               
                expect(response).to render_template(:dash)
            end
        end
    end
end