require 'rails_helper'

RSpec.describe Rider, type: :model do

   #Association Rspec Testcases
  describe 'association' do

    context 'has_many' do
      it 'rides' do
        rider = create(:rider)
        ride = create(:ride)
        rider.rides << ride
        expect(rider.rides).to include(ride)
      end
    end


    context 'has_many' do
      it 'booking_requests' do
        rider = create(:rider)
        booking_request = create(:booking_request)
        rider.booking_requests << booking_request
        expect(rider.booking_requests).to include(booking_request)
      end
    end

    context 'has_many' do
      it 'payments' do
        rider = create(:rider)
        payment = create(:payment)
        rider.payments << payment
        expect(rider.payments).to include(payment)
      end
    end

    context 'has_many' do
      it 'locations' do
        rider = create(:rider)
        location = create(:location)
        rider.locations << location
        expect(rider.locations).to include(location)
      end
    end

    # context 'has_one' do
    #   it 'user' do

    #   end
    # end

  end


  #Validation Rspec Testcases
  describe "gender" do

    before(:each) do
      rider.validate
    end

    context "when value is present" do
      let(:rider) {build(:rider , gender: "Male")}
      it "doesnt throw any error" do
        expect(rider.errors).to_not include(:gender)
      end
    end

    context "when value is not present" do
      let(:rider) {build(:rider , gender: nil)}
      it "throws error" do
        expect(rider.errors).to include(:gender)
      end
    end

  end

  describe "aadhar_no" do

    before(:each) do
      rider.validate
    end

    context "when value is present" do
      let(:rider) {build(:rider , aadhar_no: 539555819012)}
      it "doesnt throw any error" do
        expect(rider.errors).to_not include(:aadhar_no)
      end
    end

    context "when value is not present" do
      let(:rider) {build(:rider , aadhar_no: nil)}
      it "throws error" do
        expect(rider.errors).to include(:aadhar_no)
      end
    end

    context "when value exceeded 12 digits" do
      let(:rider) {build(:rider , aadhar_no: 53955581901275)}
      it "throws error" do
        expect(rider.errors).to include(:aadhar_no)
      end
    end

    context "when value preceeded 12 digits" do
      let(:rider) {build(:rider , aadhar_no: 5395558190)}
      it "throws error" do
        expect(rider.errors).to include(:aadhar_no)
      end
    end

    context "when value is alphabetic" do
      let(:rider) {build(:rider , aadhar_no: "abcdefgh")}
      it "throws error" do
        expect(rider.errors).to include(:aadhar_no)
      end
    end

    context "when value is alpha_numeric" do
      let(:rider) {build(:rider , aadhar_no: "abcd1234")}
      it "throws error" do
        expect(rider.errors).to include(:aadhar_no)
      end
    end


  end
end
