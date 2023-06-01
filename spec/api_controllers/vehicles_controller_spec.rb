require 'rails_helper'

RSpec.describe Api::VehiclesController , type: :request do


    let!(:rider) { create(:rider) }
    let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let!(:driver) { create(:driver) }
    let!(:driver_user) { create(:user , :for_driver , userable: driver) }

    let!(:driver_2) { create(:driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}

    let!(:vehicle) { create(:vehicle) }

    describe "get /vehicles#index" do
        
        context "when user is not authenticated" do
            before do   
                get "/api/vehicles"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses index" do
            before do   
                get "/api/vehicles" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses index" do
            before do   
                get "/api/vehicles" , params: { access_token: driver_user_token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /vehicles#show" do

        context "when user is not authenticated" do
            before do   
                get "/api/vehicles/32"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses show" do
            before do   
                get "/api/vehicles/32" , params: { access_token: rider_user_token.token }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses show with valid vehicle_id" do
           
            let!(:vehicle) { create(:vehicle) }
            before do   
                vehicle.driver_no = driver.id
                vehicle.save

                get "/api/vehicles/#{vehicle.id}" , params: { access_token: driver_user_token.token} 
            end            
           

            it "returns status 200" do

               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses show with invalid vehicle_id" do
          
            let!(:vehicle) { create(:vehicle) }
            before do   
                vehicle.driver_no = 101
                vehicle.save

                get "/api/vehicles/#{vehicle.id}" , params: { access_token: driver_user_token.token} 
            end
           

            it "returns status 403" do
                
               
                expect(response).to have_http_status(403)
            end
        end


    end

    describe "post /vehicles#create" do

        context "when user is not authenticated" do
            before do   
                post "/api/vehicles" , params: { name: "Apache" , type: "Bike" , seats: 2}
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access create" do
            before do   
                post "/api/vehicles" , params: { access_token: rider_user_token.token , name: "Apache" , type: "Bike" , seats: 2}
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user access create with valid params" do
            before do   
                post "/api/vehicles" , params: { access_token: driver_user_token.token , name: "Apache" , type: "Bike" , seats: 2}
            end
            it "returns status 201" do
               
                expect(response).to have_http_status(201)
            end
        end

        context "when authenticated rider_user access create with invalid params" do
            before do   
                post "/api/vehicles" , params: { access_token: driver_user_token.token , name: nil , type: "Bike" , seats: 2}
            end
            it "returns status 422" do
                
                expect(response).to have_http_status(422)
            end
        end

        

    end

    describe "patch /vehicles#update" do

        context "when user is not authenticated" do
            before do   
                patch "/api/vehicles/#{vehicle.id}"  
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses update action" do
            before do   
                patch "/api/vehicles/#{vehicle.id}" , params: { access_token: rider_user_token.token , seats: 3}
            end
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses update action with valid params" do
           
            let!(:vehicle_1) { create(:vehicle) }
            before do   
                vehicle_1.driver_no = driver.id
                vehicle_1.save

                patch "/api/vehicles/#{vehicle_1.id}" , params: { access_token: driver_user_token.token , seats: 3}
            end            
            it "return status 202" do
                
                expect(response).to have_http_status(202)
            end
        end

        context "when authenticated driver_user accesses update action with invalid params" do
           
            let!(:vehicle_1) { create(:vehicle) }
            before do   
                vehicle_1.driver_no = driver_user.userable.id
                vehicle_1.save
                patch "/api/vehicles/#{vehicle_1.id}" , params: { access_token: driver_user_token.token , seats: nil}
            end
            it "return status 422" do
                
                expect(response).to have_http_status(422)
            end
        end


    end

    describe "delete /vehicles#destroy" do

        context "when user is not authenticated" do
            before do   
                delete "/api/vehicles/32"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses destroy action" do
            before do   
                delete "/api/vehicles/32" , params: { access_token: rider_user_token.token }
            end
            it "return status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses destroy action with valid params but with invalid vehicle_id" do
           
            let!(:vehicle_4) { create(:vehicle) }
            before do   
                delete "/api/vehicles/#{vehicle_4.id}" , params: { access_token: driver_user_token.token }
            end
            it "return status 403 " do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses destroy action with valid params and valid vehicle_id" do
          
            let!(:vehicle_4)  { create(:vehicle) }
            before do       
                vehicle_4.update(driver_no: driver.id)
                delete "/api/vehicles/#{vehicle_4.id}" , params: { access_token: driver_user_token.token }
            end
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses destroy action with valid params and not found vehicle_id" do
            before do   
                delete "/api/vehicles/32" , params: { access_token: driver_user_token.token }
            end
           
            it "return status 404" do
                
               
                expect(response).to have_http_status(404)
            end
        end
    end

    describe "get /vehicles#get_vehicles_with_vehicle_type" do

        context "when user is not authenticated" do
            before do   
                get "/api/vehicles/get_vehicles_with_vehicle_type"
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses this action with invalid vehicle_type" do
            before do   
                get "/api/vehicles/get_vehicles_with_vehicle_type" , params: { access_token: rider_user_token.token  , vehicle_type: "Fazero"}
            end
            it "return status 204" do
                
                expect(response).to have_http_status(204)
            end
        end

        context "when authenticated rider_user accesses this action with invalid vehicle_type" do
            before do   
                get "/api/vehicles/get_vehicles_with_vehicle_type" , params: { access_token: rider_user_token.token  , vehicle_type: "Fazero"}
            end
            it "return status 204" do
               
                expect(response).to have_http_status(204)
            end
        end

        context "when authenticated rider_user accesses this action with valid vehicle_type" do
            before do   
                get "/api/vehicles/get_vehicles_with_vehicle_type" , params: { access_token: rider_user_token.token  , vehicle_type: "Bike"}
            end
            it "return status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user accesses this action with invalid vehicle_type" do
            before do   
                get "/api/vehicles/get_vehicles_with_vehicle_type" , params: { access_token: driver_user_token.token  , vehicle_type: "Fazero"}
            end
            it "return status 204" do
                
                expect(response).to have_http_status(204)
            end
        end

        context "when authenticated driver_user accesses this action with valid vehicle_type" do
            before do   
                get "/api/vehicles/get_vehicles_with_vehicle_type" , params: { access_token: driver_user_token.token  , vehicle_type: "Bike"}
            end
            it "return status 200" do
               
                expect(response).to have_http_status(200)
            end
        end



    end

    describe "get /vehicles#your_vehicles" do
        
        context "when user is not authenticated" do
            before do   
                get "/api/vehicles/your_vehicles"
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user accesses this action" do
            before do   
                get "/api/vehicles/your_vehicles" , params: {access_token: rider_user_token.token }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user accesses this action " do
            before do   
                get "/api/vehicles.your_vehicles" , params: { access_token: driver_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

    end


end