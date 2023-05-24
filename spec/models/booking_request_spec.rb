require 'rails_helper'

RSpec.describe BookingRequest, type: :model do

  #Association Rspec Testcases
  describe 'association' do


    context 'belongs_to' do
      it 'rider' do
        booking_request = create(:booking_request)
        rider = create(:rider)
        booking_request.rider = rider
        expect(booking_request.rider).to eq(rider)
      end
    end

    context 'has_one' do
      it 'ride' do
        booking_request = create(:booking_request)
        ride = create(:ride , booking_request: booking_request)
        expect(booking_request.ride).to eq(ride)
      end
    end


    
  end

  
  #Validation Rspec Testcases
  
  describe "city" do

    before(:each) do
      booking_request.validate
    end

    context "when value is present" do
      let(:booking_request) {build(:booking_request , city: "Coimbatore")}
      it "doesnt throw any error" do
        expect(booking_request.errors).to_not include(:city)
      end
    end

    context "when value is not present" do
      let (:booking_request) {build(:booking_request , city: nil)}
      it "throws error" do
        expect(booking_request.errors).to include(:city)
      end
    end

    


  end


  describe "booking_status" do

    before(:each) do
      booking_request.validate
    end

    context "when value is present" do
      let(:booking_request) {build(:booking_request , booking_status: "available")}
      it "doesnt throw any error" do
        expect(booking_request.errors).to_not include(:booking_status)
      end
    end

    context "when value is not present" do
      let (:booking_request) {build(:booking_request , booking_status: nil)}
      it "throws error" do
        expect(booking_request.errors).to include(:booking_status)
      end
    end

  end

  describe "vehicle_type" do

    before(:each) do
      booking_request.validate
    end

    context "when value is present" do
      let(:booking_request) {build(:booking_request , vehicle_type: "Sedan-Car")}
      it "doesnt throw any error" do
        expect(booking_request.errors).to_not include(:vehicle_type)
      end
    end

    context "when value is not present" do
      let(:booking_request) {build(:booking_request , vehicle_type: nil)}
      it "throws error" do
        expect(booking_request.errors).to include(:vehicle_type)
      end
    end

  end

  describe "from_location_name" do

    before(:each) do
      booking_request.validate
    end
    
    context "when value is present" do
      let(:booking_request) {build(:booking_request , from_location_name: "Peelamedu")}
      it "doesnt throw any error" do
        expect(booking_request.errors).to_not include(:from_location_name)
      end
    end

    context "when value is not present" do
      let(:booking_request) {build(:booking_request , from_location_name: nil)}
      it "throws error" do
        expect(booking_request.errors).to include(:from_location_name)
      end
    end


  end


  describe "to_location_name" do

    before(:each) do
      booking_request.validate
    end
    
    context "when value is present" do
      let(:booking_request) {build(:booking_request , to_location_name: "Peelamedu")}
      it "doesnt throw any error" do
        expect(booking_request.errors).to_not include(:to_location_name)
      end
    end

    context "when value is not present" do
      let(:booking_request) {build(:booking_request , to_location_name: nil)}
      it "throws error" do
        expect(booking_request.errors).to include(:to_location_name)
      end
    end


  end

  


  



end
