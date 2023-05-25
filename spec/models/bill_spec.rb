require 'rails_helper'

RSpec.describe Bill, type: :model do

  #Association Rspec Testcases
  describe 'association' do

    context "belongs_to"  do
      let(:ride) {create(:ride)}
      let(:bill) {build(:bill , ride: ride)}
      it "ride is true" do
        expect(bill.ride).to be_an_instance_of(Ride)
      end
    end

    context "belongs_to"  do
      let(:payment) {create(:payment)}
      let(:bill) {build(:bill , payment: payment)}
      it "payment is true" do
        expect(bill.payment).to be_an_instance_of(Payment)
      end
    end
  

  end


  #Validations Rspec Testcases
  describe "bill_date" do

    before(:each) do
      bill.validate
    end

    context "when value is present" do
      let(:bill) {build(:bill , bill_date: "2023-05-24")}
      it "doesnt throw any error" do
        expect(bill.errors).to_not include(:bill_date)
      end
    end

    context "when value is not present" do
      let(:bill) {build(:bill , bill_date: nil)}
      it "throws error" do
        expect(bill.errors).to include(:bill_date)
      end
    end

    context "when value is string" do
      let(:bill) {build(:bill , bill_date: "abcdefgh")}
      it "throws error" do
        expect(bill.errors).to include(:bill_date)
      end
    end
    



  end

  describe "bill_amount" do

    before(:each) do
      bill.validate
    end
    
    context "when value is present" do
      let(:bill) {build(:bill , bill_amount: 100)}
      it "doesnt throw any error" do
        expect(bill.errors).to_not include(:bill_amount)
      end
    end

    context "when value is not present" do
      let (:bill) {build(:bill , bill_amount: nil)}
      it "throws error" do
        expect(bill.errors).to include(:bill_amount)
      end
    end

    context "when value is alphabetic" do
      let (:bill) {build(:bill , bill_amount: "abcdef")}
      it "throws error" do
        expect(bill.errors).to include(:bill_amount)
      end
    end

    context "when value is alpha_numeric" do
      let (:bill) {build(:bill , bill_amount: "abcdef1011")}
      it "throws error" do
        expect(bill.errors).to include(:bill_amount)
      end
    end




  end


  describe "callbacks" do

    context "make_ride_status_as_completed" do
      let(:ride) {create(:ride)}
      let(:payment) {create(:payment)}
      
      let(:bill) {build(:bill , ride: ride , payment: payment)}
      it "sets ride status as completed" do
        bill.make_ride_as_completed
        expect(bill.ride.ride_status).to eq("completed")
      end
    end


  end


end
