require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  #Association Rspec Testcases
  describe 'association' do

    # context 'has_and_belongs_to_many' do
    #   it 'vehicles' do

    #   end
    # end

  end

  #Validations Rspec Testcases
  describe "vehicle_name" do

    before(:each) do
      vehicle.validate
    end

    context "when value is present" do
      let(:vehicle) {build(:vehicle , vehicle_name: "TVS Raider")}
      it "doesnt throw any error" do
        expect(vehicle.errors).to_not include(:vehicle_name)
      end
    end

    context "when value is not present" do
      let(:vehicle) {build(:vehicle , vehicle_name: nil)}
      it "throws error" do
        expect(vehicle.errors).to include(:vehicle_name)
      end
    end

  end

  describe "vehicle_type" do

    before(:each) do
      vehicle.validate
    end

    context "when value is present" do
      let(:vehicle) {build(:vehicle , vehicle_type: "Bike")}
      it "doesnt throw any error" do
        expect(vehicle.errors).to_not include(:vehicle_type)
      end
    end

    context "when value is not present" do
      let(:vehicle) {build(:vehicle , vehicle_type: nil)}
      it "throws error" do
        expect(vehicle.errors).to include(:vehicle_type)
      end
    end

  end

  describe "no_of_seats" do

    before(:each) do
      vehicle.validate
    end

    context "when value is present" do
      let(:vehicle) {build(:vehicle , no_of_seats: 1)}
      it "doesnt throw any error" do
        expect(vehicle.errors).to_not include(:no_of_seats)
      end
    end

    context "when value is not present" do
      let(:vehicle) {build(:vehicle , no_of_seats: nil)}
      it "throws error" do
        expect(vehicle.errors).to include(:no_of_seats)
      end
    end

  end


end
