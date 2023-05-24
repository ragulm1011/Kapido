require 'rails_helper'

RSpec.describe Payment, type: :model do

    #Association Rspec Testcases
    describe 'association' do

      context 'has_one' do
        it 'bill' do
          payment = create(:payment)
          bill = create(:bill , payment: payment)
          expect(bill.payment).to eq(payment)
        end
      end

      context 'belongs_to' do
        it 'rider' do
          payment = create(:payment)
          rider = create(:rider)
          payment.rider = rider
          expect(payment.rider).to eq(rider)
        end
      end

      context 'belongs_to' do
        it 'driver' do
          payment = create(:payment)
          driver = create(:driver)
          payment.driver = driver
          expect(payment.driver).to eq(driver)
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
