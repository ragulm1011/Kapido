require 'rails_helper'

RSpec.describe Api::LocationsController , type: :request do

    let!(:rider) { create(:rider) }
    let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let!(:driver) { create(:driver) }
    let!(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}
    

    let!(:location_1) { create(:location , rider: rider)}

    let!(:rider_2) { create(:rider) }
    let!(:rider_3) { create(:rider) }
    let!(:location_2) { create(:location , rider: rider_3) }

    describe "get /locations#index" do

        context "when user is not authenticated" do
            before do 
                get "/api/locations" 
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when driver_user access index" do
            before do 
                get "/api/locations" , params: { access_token: driver_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when rider_user access index" do
            before do 
                get "/api/locations" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /locations#show" do


        context "when user is not authenticated" do
            before do 
                get "/api/locations/32" 
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when driver_user access show" do
            before do 
                get "/api/locations/32" , params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when rider_user access show with valid params" do
            before do 
                get "/api/locations/#{location_1.id}" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when rider_user access show with invalid params" do
            before do 
                get "/api/locations/#{location_2.id}" , params: { access_token: rider_user_token.token }
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when rider_user access show with not found location_id" do
            before do 
                get "/api/locations/1000" , params: { access_token: rider_user_token.token }
            end
            it "returns status 404" do
               
                expect(response).to have_http_status(404)
            end
        end

    end

    describe "post /locations#create" do

        context "when user is not authenticated" do
            before do 
                post "/api/locations" , params: { location_name: "CKT" , landmark: "Bridge" , city: "Kovilpatti" , pincode: 628502 }
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access create" do
            before do 
                post "/api/locations" , params: { access_token: driver_user_token.token , location_name: "CKT" , landmark: "Bridge" , city: "Kovilpatti" , pincode: 628502 }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access create with valid params" do
            before do 
                post "/api/locations" , params: { access_token: rider_user_token.token , location_name: "CKT" , landmark: "Bridge" , city: "Kovilpatti" , pincode: 628502 }
            end
            it "returns status 201" do
                
                expect(response).to have_http_status(201)
            end
        end

        context "when authenticated rider_user access create with invalid params" do
            before do 
                post "/api/locations" , params: { access_token: rider_user_token.token , location_name: "CKT" , landmark: "Bridge" , city: nil , pincode: 628502 }
            end
            it "returns status 422" do
               
                expect(response).to have_http_status(422)
            end
        end

    end

    describe "patch /locations#update" do

        context "when user is not authenticated" do
            before do 
                patch "/api/locations/32" 
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access update" do
            before do 
                patch "/api/locations/32" , params: { access_token: driver_user_token.token , landmark: "Cycle Stand" }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access update with valid params" do
            before do 
                patch "/api/locations/#{location_1.id}" , params: { access_token: rider_user_token.token , landmark: "Cycle Stand" }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access update with invalid params" do
            before do 
                patch "/api/locations/#{location_1.id}" , params: { access_token: rider_user_token.token , landmark: nil }
            end
            it "returns status 422" do
                
                expect(response).to have_http_status(422)
            end
        end

        context "when authenticated rider_user access update with invalid location_id params" do
            before do 
                patch "/api/locations/#{location_2.id}" , params: { access_token: rider_user_token.token , landmark: nil }
            end
            it "returns status 403" do
              
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access update with not_found location_id params" do
            before do 
                patch "/api/locations/1000" , params: { access_token: rider_user_token.token , landmark: nil }
            end
            it "returns status 404" do
               
                expect(response).to have_http_status(404)
            end
        end
        

    end

    describe "delete /locations#destroy" do

        context "when user is not authenticated" do
            before do 
                delete "/api/locations/32"  
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access delete" do
            before do 
                delete "/api/locations/32" , params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
              
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access delete with valid location id" do
            let!(:location_5) { create(:location , rider: rider) }
            before do 
                delete "/api/locations/#{location_5.id}" , params: { access_token: rider_user_token.token }
            end
           
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access delete with invalid location id" do
            let!(:location_6) { create(:location , rider: rider_2) }
            before do 
                delete "/api/locations/#{location_6.id}" , params: { access_token: rider_user_token.token }
            end
            
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access delete with not found location id" do
            before do 
                delete "/api/locations/10000" , params: { access_token: rider_user_token.token }
            end
            
            it "returns status 404" do
                
                expect(response).to have_http_status(404)
            end
        end

    end

    describe "get /locations#get_all_default_locations" do

        context "when user is not authenticated" do
            before do 
                get "/api/locations/get_all_default_locations" 
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access this action" do
            before do 
                get "/api/locations/get_all_default_locations" , params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access this action" do
            before do 
                get "/api/locations/get_all_default_locations" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /locations#get_all_rider_personal_locations" do
        


        context "when user is not authenticated" do
            before do 
                get "/api/locations/get_all_rider_personal_locations" 
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access this action" do
            before do 
                get "/api/locations/get_all_rider_personal_locations" , params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end


        context "when authenticated rider_user access this action" do
           
            let!(:location_100) { create(:location , rider: rider)}
            before do 
                get "/api/locations/get_all_rider_personal_locations" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end



    end

end