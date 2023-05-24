require 'rails_helper'

RSpec.describe Bill, type: :model do

  #Association Rspec Testcases
  describe 'association' do


    context 'belongs_to' do
      it 'ride' do
        bill = create(:bill)
        ride = create(:ride)
        bill.ride = ride
        expect(bill.ride).to eq(ride)
      end
    end

    context 'belongs_to' do
      it 'payment' do
        bill = create(:bill)
        payment = create(:payment)
        bill.payment = payment
        expect(bill.payment).to eq(payment)
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


end
