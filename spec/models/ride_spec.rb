require 'rails_helper'

RSpec.describe Ride, type: :model do

  #Association Rspec Testcases
  describe 'association' do

    context "belongs_to"  do
      let(:rider) {create(:rider)}
      let(:ride) {build(:ride , rider: rider)}
      it "rider is true" do
        expect(ride.rider).to be_an_instance_of(Rider)
      end
    end



    context "belongs_to"  do
      let(:driver) {create(:driver)}
      let(:ride) {build(:ride , driver: driver)}
      it "driver is true" do
        expect(ride.driver).to be_an_instance_of(Driver)
      end
    end

    

    context "belongs_to"  do
      let(:booking_request) {create(:booking_request)}
      let(:ride) {build(:ride , booking_request: booking_request)}
      it "Booking_request is true" do
        expect(ride.rider).to be_an_instance_of(Rider)
      end
    end


   

    

    context "has_one" do
      [:bill , :payment].each do |model|
        it model.to_s.humanize do
          association = Ride.reflect_on_association(model).macro
          expect(association).to be(:has_one)
        end
      end
    end


    
  end

  
  #Validation Rspec Testcases
  describe "ride_date" do

    before(:each) do
      ride.validate
    end

    context "when value is present" do
      let(:ride) {build(:ride , ride_date: "2023-05-24")}
      it "doesnt throw any error" do
        expect(ride.errors).to_not include(:ride_date)
      end
    end

    context "when value is not present" do
      let(:ride) {build(:ride , ride_date: nil)}
      it "throws error" do
        expect(ride.errors).to include(:ride_date)
      end
    end

  end


  describe "callbacks" do

    context "set_ride_status" do
      let(:rider) {create(:rider)}
      let(:driver) {create(:driver)}
      let(:booking_request) {create(:booking_request)}
      let(:ride) {build(:ride , rider: rider , driver: driver , booking_request: booking_request)}
      it "sets ride status as on-ride" do
        ride.set_ride_status
        expect(ride.ride_status).to eq("on-ride")
      end
    end

    context "set_booking_status_as_booked" do
      let(:rider) {create(:rider)}
      let(:driver) {create(:driver)}
      let(:booking_request) {create(:booking_request)}
      let(:ride) {build(:ride , rider: rider , driver: driver , booking_request: booking_request)}
      it "sets booking status of booking request as booked" do
        ride.set_booking_status_as_booked
        p ride.booking_request
        expect(ride.booking_request.booking_status).to eq("booked")
      end
    end

  end
end
