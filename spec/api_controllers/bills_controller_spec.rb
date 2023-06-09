require 'rails_helper'

RSpec.describe Api::BillsController , type: :request do
    
    let!(:rider) { create(:rider) }
    let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let!(:driver) { create(:driver) }
    let!(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let!(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}

    let!(:booking_request) { create(:booking_request , rider: rider) }
    let!(:ride) { create(:ride , rider: rider , driver: driver , booking_request: booking_request)}
    let!(:payment) { create(:payment , rider: rider , driver: driver)}

    let!(:bill) { create(:bill , ride: ride , payment: payment) }
    

    describe "get /bills#index" do

        context "when user is not authenticated" do
            before do
                get '/api/bills'
            end
            it "returns status 401" do
             
              expect(response).to have_http_status(401)
            end
          end
            

        context "when authenticated rider_user accesses index" do
            before do
                get '/api/bills' , params: {access_token: rider_user_token.token}
            end
                
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses index" do
            before do
                get '/api/bills' , params: {access_token: driver_user_token.token}
            end
                
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end
        

    end


    describe "get /bills#show" do
        before do
            get "/api/bills/32"
        end
        context "when user is not authenticated" do
                
            it "returns status 401" do
             
              expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user accesses show with invalid params"  do

            before do
                get "/api/bills/300" , params: {access_token: driver_user_token.token}
            end
            
                
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses show with valid params"  do
            before do
                get "/api/bills/#{bill.id}" , params: {access_token: driver_user_token.token}
            end
                
            it "return status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user accesses show with invalid params"  do
            before do
                get "/api/bills/300" , params: {access_token: rider_user_token.token}
            end
                
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user accesses show with valid params"  do
            before do
                get "/api/bills/#{bill.id}" , params: {access_token: rider_user_token.token}
            end
            
                
            it "return status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "post /bills#create" do

        context "when user is not authenticated" do
            before do
                post "/api/bills" , params: {ride_id: ride.id , bill_amount: 500}
            end
                
            it "returns status 401" do
               
              expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses create" do
            before do
                post "/api/bills" , params: {access_token: rider_user_token.token , ride_id: ride.id , bill_amount: 500}
            end
                
            it "return status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

      

        context "when authenticated driver_user accesses create with invalid params" do
            before do
                post "/api/bills" , params: {access_token: driver_user_token.token , ride_id: ride.id , bill_amount: nil}
            end
                
            it "return status 422" do
               
                expect(response).to have_http_status(422)
            end
        end


    end

    describe "patch /bills#update" do

        context "when user is not authenticated" do
            before do
                patch "/api/bills/32" 
            end
                
            it "returns status 401" do
                
              expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses update" do
            before do
                patch "/api/bills/32" , params: {access_token: rider_user_token.token , ride_id: ride.id , bill_amount: 500}
            end
                
            it "return status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user accesses update with invalid params"  do
            before do
                patch "/api/bills/#{bill.id}" , params: {access_token: driver_user_token.token}
            end
            it "return status 422" do
               
                expect(response).to have_http_status(422)
            end
        end

        context "when authenticated driver_user accesses update with unauthorized bill id"  do
            before do
                patch "/api/bills/333" , params: {access_token: driver_user_token.token}
            end
                
            it "return status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses update with authorized bill id and valid params"  do
            before do
                patch "/api/bills/#{bill.id}" , params: {access_token: driver_user_token.token , bill_amount: 500}
            end
                
            it "return status 202" do
                
                expect(response).to have_http_status(202)
            end
        end

    end

    describe "delete /bills#destroy" do

        context "when user is not authenticated" do
            before do
                delete "/api/bills/32" 
            end
                
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses destroy" do
            before do
                delete "/api/bills/32" , params: { access_token: rider_user_token.token }
            end
            
                
            it "return status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user accesses destroy with invalid bill_id" do
            before do
                delete "/api/bills/303" , params: { access_token: driver_user_token.token }
            end
            
                
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses destroy with valid bill_id" do
            before do
                delete "/api/bills/#{bill.id}" , params: {access_token: driver_user_token.token}
            end
                
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end


    end

    describe "get /bills#your_bills" do

        context "when user is not authenticated" do
            before do
                get "/api/bills/your_bills" 
            end
                
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access your_bills" do
                
            let!(:bill_2) { create(:bill , ride: ride , payment: payment)}
            before do
                get "/api/bills/your_bills" , params: { access_token: driver_user_token.token }
            end
            it "return status 200" do
               
               
                expect(response).to have_http_status(:ok)
            end
        end

        context "when authenticated rider_user access your_bills" do
                
            let!(:bill_3) { create(:bill , ride: ride , payment: payment)}
            before do
                get "/api/bills/your_bills" , params: { access_token: rider_user_token.token }
            end
            it "return status 200" do
               
               
                expect(response).to have_http_status(:ok)
            end
        end


    end

end