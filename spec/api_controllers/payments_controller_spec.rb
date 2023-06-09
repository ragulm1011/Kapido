require 'rails_helper'

RSpec.describe Api::PaymentsController , type: :request do


    let!(:rider) { create(:rider) }
    let!(:rider_user) {  create(:user , :for_rider , userable: rider) }

    let!(:driver) { create(:driver) }
    let!(:driver_user) { create(:user , :for_driver , userable: driver) }

    # let(:customer_token) {create(:doorkeeper_access_token , resource_owner_id: customer_user.id)}

    let!(:rider_user_token) { create(:doorkeeper_access_token , resource_owner_id: rider_user.id)}
    let!(:driver_user_token) { create(:doorkeeper_access_token , resource_owner_id: driver_user.id)}


    let!(:payment_1) { create(:payment , rider: rider , driver: driver)}

    let!(:rider_2) { create(:rider)}

    let!(:driver_2) { create(:driver)}
    
    describe "get /payments#index" do

        context "when user is not authenticated" do
            before do
                get "/api/payments" 
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access index" do
            before do
                get "/api/payments" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user access index" do
            before do
                get "/api/payments" , params: { access_token: driver_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /payments#show" do


        context "when user is not authenticated" do
            before do
                get "/api/payments/32" 
            end
            it "returns status 401" do
              
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access index with valid payment_id" do
            before do
                get "/api/payments/#{payment_1.id}" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access index with invalid payment_id" do
            let!(:payment_2) { create(:payment , rider: rider_2 , driver: driver)  }
            before do
                get "/api/payments/#{payment_2.id}" , params: { access_token: rider_user_token.token }
            end
            
            it "returns status 403" do
              
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access index with not_found payment_id" do
            before do
                get "/api/payments/10000" , params: { access_token: rider_user_token.token }
            end
            # let(:payment_2) { create(:payment , rider: rider_2 , driver: driver)  }
            it "returns status 404" do
                
                expect(response).to have_http_status(404)
            end
        end


        context "when authenticated driver_user access index with valid payment_id" do
            before do
                get "/api/payments/#{payment_1.id}" , params: { access_token: driver_user_token.token } 
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access index with invalid payment_id" do
            let!(:payment_6) { create(:payment , rider: rider_2 , driver: driver_2)  }
            before do
                get "/api/payments/#{payment_6.id}" , params: { access_token: driver_user_token.token }
            end
           
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated driver_user access index with not_found payment_id" do
            before do
                get "/api/payments/10000" , params: { access_token: driver_user_token.token }
            end
            # let(:payment_2) { create(:payment , rider: rider_2 , driver: driver)  }
            it "returns status 404" do
              
                expect(response).to have_http_status(404)
            end
        end

    end

    describe "post /payments#create" do

        context "when user is not authenticated" do
            before do
                post "/api/payments" , params: { driver_id: 1 , mode_of_payment: "Gpay" , amount: 100 , credentials: "Done for a ride" , remarks: "Nothing" , bill_no: 1} 
            end
            it "returns status 401" do
               
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access create" do
            before do
                post "/api/payments" ,  params: { access_token: driver_user_token.token , driver_id: 1 , mode_of_payment: "Gpay" , amount: 100 , credentials: "Done for a ride" , remarks: "Nothing" , bill_no: 1 } 
            end
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access create with valid params" do
            let!(:driver_1) { create(:driver) }
            before do
                post "/api/payments" ,  params: { access_token: rider_user_token.token , driver_id: driver_1.id , mode_of_payment: "Gpay" , amount: 100 , credentials: "Done for a ride" , remarks: "Nothing" , bill_no: 1 } 
            end
            it "returns status 201" do
               
                expect(response).to have_http_status(201)
            end
        end

        context "when authenticated rider_user access create with invalid params" do
            before do
                post "/api/payments" ,  params: { access_token: rider_user_token.token , driver_id: 1 , mode_of_payment: nil , amount: 100 , credentials: "Done for a ride" , remarks: "Nothing" , bill_no: 1 } 
            end
            it "returns status 422" do
               
                expect(response).to have_http_status(422)
            end
            
        end


    end

    describe "patch /payments#update" do


        context "when user is not authenticated" do
            before do
                patch "/api/payments/32"  
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access update" do
            before do
                patch "/api/payments/32" ,  params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access update with valid params" do
            before do
                patch "/api/payments/#{payment_1.id}" ,  params: { access_token: rider_user_token.token  , amount: 1500}
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated rider_user access update with invalid params" do
            before do
                patch "/api/payments/#{payment_1.id}" ,  params: { access_token: rider_user_token.token  , amount: nil }
            end
            it "returns status 422" do
                
                expect(response).to have_http_status(422)
            end
        end

        context "when authenticated rider_user access update with not found payment_id params" do
            before do
                patch "/api/payments/1000" ,  params: { access_token: rider_user_token.token  , amount: 1500}
            end
            it "returns status 404" do
                
                expect(response).to have_http_status(404)
            end
        end

        context "when authenticated rider_user access update with invalid payment_id params" do
            let!(:payment_7) { create(:payment , rider: rider_2 , driver: driver) }
            before do
                patch "/api/payments/#{payment_7.id}" ,  params: { access_token: rider_user_token.token  , amount: 1500}
            end
            
            it "returns status 403" do
                
                expect(response).to have_http_status(403)
            end
        end

    end

    describe "delete /payments#destroy" do
        

        context "when user is not authenticated" do
            before do
                delete "/api/payments/32"  
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated driver_user access delete" do
            before do
                delete "/api/payments/32" ,  params: { access_token: driver_user_token.token }
            end
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

       

        context "when authenticated rider_user access update with invalid payment_id params" do
            before do
                delete "/api/payments/#{payment_10.id}" ,  params: { access_token: rider_user_token.token  }
            end
            let!(:payment_10) { create(:payment , rider: rider_2 , driver: driver) }
            it "returns status 403" do
               
                expect(response).to have_http_status(403)
            end
        end

        context "when authenticated rider_user access delete with not found payment_id params" do
            before do
                delete "/api/payments/1000" ,  params: { access_token: rider_user_token.token }
            end
            it "returns status 404" do
                
                expect(response).to have_http_status(404)
            end
        end


    end

    describe "get /payments#your_payments" do

        context "when user is not authenticated" do
            before do
                get "/api/payments/your_payments"  
            end
            it "returns status 401" do
                
                expect(response).to have_http_status(401)
            end
        end

        context "when authenticated rider_user access this action" do
            
            let!(:payment_11) { create(:payment , rider: rider , driver: driver) }
            before do
                get "/api/payments/your_payments" , params: { access_token: rider_user_token.token }
            end
            it "returns status 200" do
                
                expect(response).to have_http_status(200)
            end
        end

        context "when authenticated driver_user access this action" do
           
            let!(:payment_12) { create(:payment , rider: rider , driver: driver) }
            before do
                get "/api/payments/your_payments" , params: { access_token: driver_user_token.token }
            end
            it "returns status 200" do
               
                expect(response).to have_http_status(200)
            end
        end
        
    end

end


