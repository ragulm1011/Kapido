require 'rails_helper'

RSpec.describe Api::BookingRequestsController , type: :request do
    

    let!(:rider) { create(:rider) }
    let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let!(:driver) { create(:driver) }
    let!(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}

    let!(:booking_request) { create(:booking_request , rider: rider) }
    let!(:ride) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}

    let!(:rider_2) { create(:rider)}
    let!(:booking_request_1) { create(:booking_request , rider: rider_2)}
    
    describe "get /booking_requests#index" do

        context "when user is not authenticated" do
            before do
                get "/api/booking_requests"
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user accesses the index action" do
            before do
                get "/api/booking_requests" , params: { access_token: driver_user_token.token}  
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user accesses the index action" do
            before do
                get "/api/booking_requests" , params: { access_token: rider_user_token.token}  
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /booking_requests#show" do

        context "when user is not authenticated" do
            before do
                get "/api/booking_requests/32"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses the show action" do
           
            let(:booking_request_1) { create(:booking_request) }
            before do
                get "/api/booking_requests/#{booking_request_1.id}" , params: { access_token: rider_user_token.token}  
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses the show action with valid booking id and same city" do
            
            let(:booking_request_1) { create(:booking_request) }
            before do
                booking_request_1.update(city: "Trichy")
                driver.update(standby_city: "Trichy")

                get "/api/booking_requests/#{booking_request_1.id}" , params: { access_token: driver_user_token.token}  
            end
           
            it "returns status 200" do

               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses the show action with not found booking id" do
            before do
                get "/api/booking_requests/32" , params: { access_token: driver_user_token.token}  
            end
            it "returns status 404" do
                
                expect(response).to have_http_status(404)
            end
        end

    end

    describe "post /booking_requests#create" do

        context "when user is not authenticated" do
            before do
                post "/api/booking_requests"
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when autenticated driver_user access create" do
            before do
                post "/api/booking_requests" , params: { access_token: driver_user_token.token}
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when autheticated rider_user access create with valid params" do
            before do
                post "/api/booking_requests" , params: { access_token: rider_user_token.token  , from_location_name: "Rathinam College" , to_location_name: "Rathinam College" , city: "Coimbatore" , vehicle_type: "Bike"}
            end
            it "return status 201" do
                
                expect(response).to have_http_status(201)
            end
        end

        context "when autheticated rider_user access create with invalid params" do
            before do
                post "/api/booking_requests" , params: { access_token: rider_user_token.token  , from_location_name: "Rathinam College" , to_location_name: "Rathinam College" , city: nil , vehicle_type: "Bike"}
            end
            it "return status 422" do
               
                expect(response).to have_http_status(422)
            end
        end

    end

    describe "patch /booking_requests#update" do

        context "when user is not authenticated" do
            before do
                patch "/api/booking_requests/32"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when autenticated driver_user access update" do
            before do
                patch "/api/booking_requests/32" , params: { access_token: driver_user_token.token , city: "Kovilpatti"}
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end


        context "when authenticated rider_user access update with valid params and valid booking_id" do
            before do
                patch "/api/booking_requests/#{booking_request.id}" , params: { access_token: rider_user_token.token , city: "Trichy"}
            end

            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access update with invalid params and valid booking_id" do
            before do
                patch "/api/booking_requests/#{booking_request.id}" , params: { access_token: rider_user_token.token , city: nil }
            end

            it "return status 422" do
               
                expect(response).to have_http_status(422)
            end
        end

        context "when authenticated rider_user access update with valid params and invalid booking_id" do
            before do
                patch "/api/booking_requests/#{booking_request_1.id}" , params: { access_token: rider_user_token.token , city: "Trichy" }
            end

            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access update with valid params and not found booking_id" do
            before do
                patch "/api/booking_requests/1000" , params: { access_token: rider_user_token.token , city: "Trichy" }
            end

            it "return status 404" do
                
                expect(response).to have_http_status(404)
            end
        end




    end

    describe "delete /booking_requests#destroy" do

        context "when user is not authenticated" do
            before do
                delete "/api/booking_requests/32"
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end 

        context "when autenticated driver_user access destroy" do
            before do
                delete "/api/booking_requests/32" , params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access destroy with valid params" do
            let(:booking_request_5) { create(:booking_request , rider: rider)}
            before do
                delete "/api/booking_requests/#{booking_request_5.id}" , params: { access_token: rider_user_token.token }
            end
            
            it "return status 200"  do
                
                expect(response).to have_http_status(200)

            end
        end

        context "when authenticated rider_user access destroy with invalid params" do
           
            let(:booking_request_6) { create(:booking_request , rider: rider_2) }
            before do
                delete "/api/booking_requests/#{booking_request_6.id}" , params: { access_token: rider_user_token.token }
            end
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access destroy with not found booking_id"   do
            before do
                delete "/api/booking_requests/10000" , params: { access_token: rider_user_token.token }
            end
            it "return status 404 " do
               
                expect(response).to have_http_status(404)
            end
        end

    end

    describe "get /booking_requests#your_booking_request" do
        
        context "when user is not authenticated" do
            before do
                get "/api/booking_requests/yout_booking_requests"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end 

        context "when authenticated rider_user access get your_booking_request" do
            before do
                get "/api/booking_requests/your_booking_requests" , params: { access_token: rider_user_token.token }
            end
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user access get your_booking_request" do
           
           
            let!(:booking_request1) { create(:booking_request , rider: rider)}
            before do
                get "/api/booking_requests/your_booking_requests" , params: { access_token: driver_user_token.token }
            end
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end



    end
 
end
