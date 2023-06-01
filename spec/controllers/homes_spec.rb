require 'rails_helper'

RSpec.describe HomesController, type: :controller do

    let(:rider) { create(:rider) }
    let(:driver) { create(:driver) }

    let(:rider_user) { create(:user , :for_rider , userable: rider) }
    let(:driver_user) { create(:user , :for_driver , userable: driver)}
    
    describe "get /homes#index" do

        context "when the user is not signed in" do
            before do   
                get :index
            end
            it "renders index template" do

                
                expect(:response).to render_template(:index)
            end
        end

        context "when the driver_user is signed in" do
            before do   
                sign_in driver_user
                get :index
            end
            it "renders index template" do
                
                expect(:response).to render_template(:index)
            end
        end

        context "when the rider_user is signed in" do
            before do   
                sign_in rider_user
                get :index
            end
            it "renders index template" do
               
                expect(:response).to render_template(:index)
            end
        end

    end
end