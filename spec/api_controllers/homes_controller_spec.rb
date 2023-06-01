


    require 'rails_helper'

RSpec.describe Api::HomesController , type: :request do


    let(:rider) { create(:rider) }
    let(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:application) {create(:doorkeeper_application)}

    let(:token) { create(:doorkeeper_access_token , application: application)}
    let(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}
    let(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}



    
    
    describe "get /homes#index" do
        

        

        context "when user is not authenticated" do
            before do
                get "/api"
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when user is authenticated with client credentials grant flow" do
            before do
                get "/api" , params: { access_token: token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end


        context "when authenticated driver_user acess index" do
            before do
                get "/api" , params: { access_token:driver_user_token.token}
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user acess index" do
            before do
                get "/api" , params: { access_token: rider_user_token.token}
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end
    end

end