require 'rails_helper'

RSpec.describe Ride, type: :model do

  #Association Rspec Testcases
  describe 'association' do


    context 'belongs_to' do
      it 'rider' do
        ride = create(:ride)
        rider = create(:rider)
        ride.rider = rider
        expect(ride.rider).to eq(rider)
      end
    end

    context 'belongs_to' do
      it 'driver' do
        ride = create(:ride)
        driver = create(:driver)
        ride.driver = driver
        expect(ride.driver).to eq(driver)
      end
    end

    context 'belongs_to' do
      it 'booking_request' do
        booking_request = create(:booking_request)
        ride = create(:ride)
        ride.booking_request = booking_request
        expect(ride.booking_request).to eq(booking_request)
      end
    end


    context 'has_one' do
      it 'bill' do
        ride = create(:ride)
        bill = create(:bill , ride: ride)
        expect(ride.bill).to eq(bill)
      end
    end

    # context 'has_one' do
    #   it 'payment' do
        
        
    #   end
    # end


    
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
end
