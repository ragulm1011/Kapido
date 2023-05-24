require 'rails_helper'

RSpec.describe Driver, type: :model do

   #Association Rspec Testcases
   describe 'association' do

    # context 'has_and_belongs_to_many' do
    #   it 'vehicles' do
        
    #   end
    # end

    context 'has_many' do
      it 'payments' do
        driver = create(:driver)
        payment = create(:payment)
        driver.payments << payment
        expect(driver.payments).to include(payment)
      end
    end

    context 'has_many' do
      it 'rides' do
        driver = create(:driver)
        ride = create(:ride)
        driver.rides << ride
        expect(driver.rides).to include(ride)
      end
    end

    # context 'has_many through payments' do
    #   it 'riders' do

    #   end
    # end


    # context 'has_one' do
    #   it 'user' do

    #   end
    # end


   end

   #Validation Rspec Testcases  
  describe "liscense_no" do

    before(:each) do
      driver.validate
    end

    context "when value is present" do
      let(:driver) {build(:driver , liscense_no: "CTFPR1048K")}
      it "doesnt throw any error" do
        expect(driver.errors).to_not include(:liscense_no)
      end
    end

    context "when value is not present" do
      let(:driver) {build(:driver , liscense_no: nil)}
      it "throws error" do
        expect(driver.errors).to include(:liscense_no)
      end
    end

  end


  describe "driver_rating" do

    before(:each) do
      driver.validate
    end

    context "when value is present" do
      let(:driver) {build(:driver , driver_rating: 3)}
      it "doesnt throw any error" do
        expect(driver.errors).to_not include(:driver_rating)
      end
    end

    context "when value is not present" do
      let(:driver) {build(:driver , driver_rating: nil)}
      it "throws error" do
        expect(driver.errors).to include(:driver_rating)
      end
    end

    context "when value is less than 0" do
      let(:driver) {build(:driver , driver_rating: -1)}
      it "throws error" do
        expect(driver.errors).to include(:driver_rating)
      end
    end

    context "when value is greater than 5" do
      let(:driver) {build(:driver , driver_rating: 6)}
      it "throws error" do
        expect(driver.errors).to include(:driver_rating)
      end
    end

    context "when value is alphabetic" do
      let(:driver) {build(:driver , driver_rating: "abcdef")}
      it "throws error" do
        expect(driver.errors).to include(:driver_rating)
      end
    end

    context "when value is alpha_numeric" do
      let(:driver) {build(:driver , driver_rating: "abcd12345")}
      it "throws error" do
        expect(driver.errors).to include(:driver_rating)
      end
    end

  end


end
