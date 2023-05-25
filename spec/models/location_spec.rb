require 'rails_helper'

RSpec.describe Location, type: :model do
  #Association Rspec Testcases
  describe 'association' do

    context "belongs_to"  do
      let(:rider) {create(:rider)}
      let(:location) {build(:location , rider: rider)}
      it "rider is true" do
        expect(location.rider).to be_an_instance_of(Rider)
      end
    end


  end

  #Validation Rspec Testcases
  describe "location_name" do

    before(:each) do
      location.validate
    end

    context "when value is present" do
      let(:location) {build(:location , location_name: "CKT")}
      it "doesnt throw any error" do
        expect(location.errors).to_not include(:location_name)
      end
    end

    context "when value is not present" do
      let(:location) {build(:location , location_name: nil)}
      it "throws error" do
        expect(location.errors).to include(:location_name)
      end
    end

  end

  describe "landmark" do

    before(:each) do
      location.validate
    end

    context "when value is present" do
      let(:location) {build(:location , landmark: "Near bridge")}
      it "doesnt throw any error" do
        expect(location.errors).to_not include(:landmark)
      end
    end

    context "when value is not present" do
      let(:location) {build(:location , landmark: nil)}
      it "throws error" do
        expect(location.errors).to include(:landmark)
      end
    end

  end

  describe "city" do

    before(:each) do
      location.validate
    end

    context "when value is present" do
      let(:location) {build(:location , city: "Coimbatore")}
      it "doesnt throw any error" do
        expect(location.errors).to_not include(:city)
      end
    end

    context "when value is not present" do
      let(:location) {build(:location , city: nil)}
      it "throws error" do
        expect(location.errors).to include(:city)
      end
    end

  end

  describe "pincode" do

    before(:each) do
      location.validate
    end

    context "when value is present" do
      let(:location) {build(:location , pincode: 628502)}
      it "doesnt throw any error" do
        expect(location.errors).to_not include(:pincode)
      end
    end

    context "when value is not present" do
      let(:location) {build(:location , pincode: nil)}
      it "throws error" do
        expect(location.errors).to include(:pincode)
      end
    end

    context "when value exceeds 6 digits" do
      let(:location) {build(:location , pincode: 6285087)}
      it "throws error" do
        expect(location.errors).to include(:pincode)
      end
    end

    context "when value preceeds 6 digits" do
      let(:location) {build(:location , pincode: 62850)}
      it "throws error" do
        expect(location.errors).to include(:pincode)
      end
    end

    context "when value is alphabetic" do
      let(:location) {build(:location , pincode: "abcdefg")}
      it "throws error" do
        expect(location.errors).to include(:pincode)
      end
    end

    context "when value is alpha_numeric" do
      let(:location) {build(:location , pincode: "abcdefg123")}
      it "throws error" do
        expect(location.errors).to include(:pincode)
      end
    end



  end



end
