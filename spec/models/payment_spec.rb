require 'rails_helper'

RSpec.describe Payment, type: :model do

    #Association Rspec Testcases
    describe 'association' do

      context "has_one" do
        [:bill].each do |model|
          it model.to_s.humanize do
            association = Payment.reflect_on_association(model).macro
            expect(association).to be(:has_one)
          end
        end
      end

     
      context "belongs_to"  do
        let(:rider) {create(:rider)}
        let(:payment) {build(:payment , rider: rider)}
        it "rider is true" do
          expect(payment.rider).to be_an_instance_of(Rider)
        end
      end

      context "belongs_to"  do
        let(:driver) {create(:driver)}
        let(:payment) {build(:payment , driver: driver)}
        it "driver is true" do
          expect(payment.driver).to be_an_instance_of(Driver)
        end
      end

    end

  
    #Validation Rspec Testcases
    describe "mode_of_payment" do

        before(:each) do
          payment.validate
        end

        context "when value is present" do
            let(:payment) {build(:payment , mode_of_payment: "Gpay")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:mode_of_payment)
            end
          end
      
          context "when value is not present" do
            let(:payment) {build(:payment , mode_of_payment: nil)}
            it "throws error" do
              expect(payment.errors).to include(:mode_of_payment)
            end
          end

    end

    describe "amount" do

        before(:each) do
          payment.validate
        end

        context "when value is present" do
            let(:payment) {build(:payment , amount: 100)}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:amount)
            end
          end
      
          context "when value is not present" do
            let(:payment) {build(:payment , amount: nil)}
            it "throws error" do
              expect(payment.errors).to include(:amount)
            end
          end

    end

    describe "credentials" do

        before(:each) do
          payment.validate
        end

        context "when value is present" do
            let(:payment) {build(:payment , credentials: "8778846924")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:credentials)
            end
          end
      
          context "when value is not present" do
            let(:payment) {build(:payment , credentials: nil)}
            it "throws error" do
              expect(payment.errors).to include(:credentials)
            end
          end

    end

    describe "payment_date" do

        before(:each) do
          payment.validate
        end

        context "when value is present" do
            let(:payment) {build(:payment , payment_date: "2023-05-24")}
            it "doesnt throw any error" do
              expect(payment.errors).to_not include(:payment_date)
            end
          end
      
          context "when value is not present" do
            let(:payment) {build(:payment  , payment_date: nil)}
            it "throws error" do
              expect(payment.errors).to include(:payment_date)
            end
          end

    end
    
end
