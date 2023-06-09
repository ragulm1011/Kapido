require 'rails_helper'

RSpec.describe Api::RidersController , type: :request do

  let!(:rider) { create(:rider) }
  let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

  let!(:driver) { create(:driver) }
  let!(:driver_user) { create(:user , :for_driver , userable: driver) }

  let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
  let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}
  
  let!(:booking_request) {create(:booking_request , rider: rider)  }
  let!(:ride) { create(:ride , rider: rider , driver: driver , booking_request: booking_request) }

    describe "get /riders#index" do
        
        context "when user is not authenticated" do
          before do
            get '/api/riders'
          end
            it "returns status 401" do
             
              expect(response).to have_http_status(401)
            end
          end

          context "when driver_user is authenticated" do
            before do
              get "/api/riders" , params: { access_token: driver_user_token.token}
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
          end

          context "when rider_user is authenticated" do
            before do
              get "/api/riders" , params: { access_token: rider_user_token.token}
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
          end

    end

    describe "get /riders#show" do
      
      
      context "when user is not authenticated" do
        before do
          get '/api/riders/32'
        end
        it "returns status 401" do
          
          expect(response).to have_http_status(401)
        end
      end

      context "when authnticated driver_user accesses show" do
        before do
          get '/api/riders/32' , params: { access_token: driver_user_token.token }
        end
        it "returns status 403" do
          
          expect(response).to have_http_status(403)
        end
      end

      context "when authenticated rider_user accesses show" do
        before do
          get "/api/riders/#{rider.id}" , params: { access_token: rider_user_token.token}
        end
        it "returns status 200" do
          
          expect(response).to have_http_status(200)
        end
      end

      

    end

    describe "patch /riders#update" do

      context "when user is not authenticated" do
        before do
          patch '/api/riders/32'
        end
        it "returns status 401" do
         
          expect(response).to have_http_status(401)
        end
      end

      context "when authnticated driver_user accesses update" do
        before do
          patch '/api/riders/32' , params: { access_token: driver_user_token.token}
        end
        it "return status code 403" do
          
          expect(response).to have_http_status(403)
        end
      end

      context "when authenticated rider_user accesses update with invalid params" do
        before do
          patch "/api/riders/#{rider.id}" , params: {access_token: rider_user_token.token , aadhar_no: nil}
        end
        it "return status 422" do
          
          expect(response).to have_http_status(422)
        end

      end

      context "when authenticated rider_user accesses update with valid params" do
        before do
          patch "/api/riders/#{rider.id}" , params: {access_token: rider_user_token.token , aadhar_no: 539555819012}
        end
        it "return status 202" do
          
          expect(response).to have_http_status(202)
        end

      end

    end

end