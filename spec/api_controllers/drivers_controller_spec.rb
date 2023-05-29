require 'rails_helper'

RSpec.describe Api::DriversController , type: :request do

    let(:rider) { create(:rider) }
    let(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let(:driver) { create(:driver) }
    let(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}
    
    describe "get /drivers#index" do

        context "when user is not authenticated" do
            it "returns status 401 " do
                get "/api/drivers"
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access index" do
            it "return status 200" do
                get "/api/drivers" , params: { access_token: rider_user_token.token }
                expect(response).to have_http_status(200)
             end
        end

        context "when authenticated driver_user access index" do
            it "return status 200" do
                get "/api/drivers", params: { access_token: driver_user_token.token}
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /drivers#show" do

        context "when user is not authenticated" do
            it "returns status 401 " do
                get "/api/drivers/32"
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access index" do
            it "return status 200" do
                get "/api/drivers/#{driver.id}" , params: { access_token: rider_user_token.token }
                expect(response).to have_http_status(200)
             end
        end

        context "when authenticated driver_user access index" do
            it "return status 200" do
                get "/api/drivers/#{driver.id}", params: { access_token: driver_user_token.token}
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "patch /drivers#update" do

        context "when user is not authenticated" do
            it "returns status 401 " do
                patch "/api/drivers/32" , params: { city: "San Francisco" }
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access update"  do
            it "returns status 403" do
                patch "/api/drivers/32" , params: { access_token: rider_user_token.token , city: 'San Francisco'}
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user access update" do
            it "return status 200" do
                patch "/api/drivers/#{driver.id}", params: { access_token: driver_user_token.token , city: "San Francisco"}
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /drivers#available_ride" do
        
        context "when user is not authenticated" do
            let(:booking_request_1) { create(:booking_request , rider: rider) }
            it "return status 401" do
                get "/api/drivers/available_ride" , params: { city: "San Francisco" }
                expect(response).to have_http_status(401)
            end
        end

        context "when rider_user access available_ride" do
            let(:booking_request_1) { create(:booking_request , rider: rider) }
                it "return status 403" do
                    get "/api/drivers/available_ride" , params: { access_token: rider_user_token.token  , city: "San Francisco"}
                    expect(response).to have_http_status(403)
                end
        end

        # context "when driver_user access available_ride with valid city params" do
        #     let!(:booking_request_1) { create(:booking_request , rider: rider) }
        #     it "returns status 200" do
        #         get "/api/drivers/available_ride" , params: { access_token: driver_user_token.token , city: "San Francisco" }
        #         expect(response).to have_http_status(200)
        #     end
        # end

        context "when driver_user access available_ride with invalid city params" do
            let!(:booking_request_1) { create(:booking_request , rider: rider) }
            it "returns status 204 " do
                get "/api/drivers/available_ride" , params: { access_token: driver_user_token.token , city: "Kallapatti" }
                expect(response).to have_http_status(204)
            end
        end


    end

    describe "get /drivers#drivers_with_standby_city" do


        context "when user is not authenticated" do
            it "returns status 401 " do
                get "/api/drivers/drivers_with_standby_city" , params: { city: "Coimbatore" }
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access this action" do
            it "returns status 200 " do
                get "/api/drivers/drivers_with_standby_city" , params: { access_token: driver_user_token.token , city: "Coimbatore" }
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access this action" do
            it "returns status 200 " do
                get "/api/drivers/drivers_with_standby_city" , params: { access_token: rider_user_token.token , city: "Coimbatore" }
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access this action with invalid city params" do
            it "returns status 204 " do
                get "/api/drivers/drivers_with_standby_city" , params: { access_token: rider_user_token.token , city: "Kallapatti" }
                expect(response).to have_http_status(204)
            end
        end

        context "when authenticated driver_user access this action with invalid city params" do
            it "returns status 204 " do
                get "/api/drivers/drivers_with_standby_city" , params: { access_token: driver_user_token.token , city: "Kallapatti" }
                expect(response).to have_http_status(204)
            end
        end
        
        


    end

    describe "get /drivers#drivers_with_rating_above_3" do
        
        context "when user is not authenticated" do
            it "returns status 401 " do
                get "/api/drivers/drivers_rating_above_3"
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access this action" do
            it "returns status 200 " do
                get "/api/drivers/drivers_with_rating_above_3" , params: { access_token: driver_user_token.token }
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access this action" do
            it "returns status 200 " do
                get "/api/drivers/drivers_with_rating_above_3" , params: { access_token: rider_user_token.token }
                expect(response).to have_http_status(200)
            end
        end

    end

end