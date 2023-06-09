require 'rails_helper'

RSpec.describe Api::RidesController , type: :request do

    let!(:rider) { create(:rider) }
    let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let!(:driver) { create(:driver) }
    let!(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}

    let!(:booking_request) { create(:booking_request , rider: rider) }
    let!(:ride) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
    
    let!(:driver_2) { create(:driver) }
    let!(:rider_2) { create(:rider) }
    let!(:ride_2) { create(:ride , rider: rider_2 , driver: driver_2)}

    describe "get /rides#index" do

        context "when user is not authenticated" do
            before do  
                   get "/api/rides"
            end
            it "return status 401" do
             
                expect(response).to have_http_status(401)
            end
        end

        context "when driver_user is authenticated" do
            before do  
                 get "/api/rides" , params: { access_token: driver_user_token.token }
            end
            it "return status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when rider_user  authenticated" do
            before do  
                get "/api/rides" , params: { access_token: rider_user_token.token }
            end
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /rides#show" do

        context "when user is not authenticated" do
            before do  
                 get "/api/rides/32"
            end
            it "return status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when driver_user is authenticated with valid params" do
            let!(:ride_1) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            before do  
                get "/api/rides/#{ride_1.id}" , params: { access_token: driver_user_token.token}
            end
            
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when driver_user is authenticated with invalid params" do
            before do  
                get "/api/rides/#{ride_2.id}" , params: { access_token: driver_user_token.token}
            end
            
            it "return status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when driver_user is authenticated with invalid params with no ride found" do
            before do  
                 get "/api/rides/100" , params: { access_token: driver_user_token.token}
            end
            
            it "return status 404" do
               
                expect(response).to have_http_status(404)
            end
        end

        context "when rider_user is authenticated with valid params" do
            
            let!(:ride_1) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            before do  
                get "/api/rides/#{ride_1.id}" , params: { access_token: rider_user_token.token}
            end
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when rider_user is authenticated with invalid params" do
            before do  
                get "/api/rides/#{ride_2.id}" , params: { access_token: rider_user_token.token}
            end
            
            it "return status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when rider_user is authenticated with invalid params with no ride found" do
            before do  
                 get "/api/rides/100" , params: { access_token: rider_user_token.token}
            end
            
            it "return status 404" do
               
                expect(response).to have_http_status(404)
            end
        end


    end

    describe "post /rides#create" do
        
        context "when user is not authenticated" do
            before do  
                post "/api/rides" , params: {rider_id: rider.id , booking_id: booking_request.id}
            end
            it "return status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses create action" do
            before do  
                post "/api/rides" , params: {rider_id: rider.id , booking_id: booking_request.id , access_token: rider_user_token.token}
            end
            it "return status 403" do
                
                expect(response).to have_http_status(403)

            end
        end


        context "when authenticated driver_user accesses create action with valid params" do
            before do  
                post "/api/rides" , params: {rider_id: rider.id , booking_id: booking_request.id , access_token: driver_user_token.token}
            end
            it "return status 202" do
                
                expect(response).to have_http_status(202)
            end
        end

        context "when authenticated driver_user accesses create action with invalid params" do
            before do  
                post "/api/rides" , params: {rider_id: rider.id , booking_id: nil , access_token: driver_user_token.token}
            end
            it "return status 422" do
                
                expect(response).to have_http_status(422)
            end
        end

    end

    describe "patch /rides#update" do

        context "when user is not authenticated" do
            before do  
                patch "/api/rides/42"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user acccesses update action" do
            before do  
                patch "/api/rides/#{ride.id}" , params: { access_token: rider_user_token.token }
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses update action with valid params" do
            before do  
                patch "/api/rides/#{ride.id}" , params: { access_token: driver_user_token.token , rider_id: rider.id , booking_id: booking_request.id}
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

       

        context "when authenticated driver_user accesses update action with invalid ride_id" do
            before do  
                patch "/api/rides/#{ride_2.id}" , params: { access_token: driver_user_token.token , rider_id: rider.id , booking_id: nil}
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

    end

    describe "delete /rides#destroy" do

        context "when user is not authenticated" do
            let!(:ride_3) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            before do  
                delete "/api/rides/#{ride_3.id}"
            end
            
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access destroy" do
           
            let!(:ride_3) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            before do  
                delete "/api/rides/#{ride_3.id}" , params: { access_token: rider_user_token.token }
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user access destroy with valid ride_id" do
          
            let!(:ride_3) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            before do  
                delete "/api/rides/#{ride_3.id}" , params: { access_token: driver_user_token.token }
            end            
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user access destroy with invalid ride_id" do
            before do  
                delete "/api/rides/#{ride_3.id}" , params: { access_token: driver_user_token.token }
            end
            let!(:ride_3) { create(:ride , rider: rider_2 , driver: driver_2 , booking_request: booking_request)}
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end



    end

    describe "get /rides#your_rides" do
        
        context "when user is not authenticated" do
            before do  
                get "/api/rides/your_rides"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses your_rides action" do
            
            let!(:ride_5) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            before do  
                get "/api/rides/your_rides" , params: { access_token: rider_user_token.token }
             end

            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses your_rides action" do
            before do  
                get "/api/rides/your_rides" , params: { access_token: driver_user_token.token }
            end
            let!(:ride_5) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

    end

end