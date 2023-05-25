require 'rails_helper'

RSpec.describe Rider, type: :model do

   #Association Rspec Testcases
  describe 'association' do

    context "has_many" do

      [:rides , :booking_requests , :payments , :locations].each do |each|
        it each.to_s.humanize do
          association = Rider.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end

   

    context "has_one" do
      it "user" do
        association = Rider.reflect_on_association(:user).macro
        expect(association).to be(:has_one)
      end
    end

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
