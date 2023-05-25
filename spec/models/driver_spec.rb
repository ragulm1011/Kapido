require 'rails_helper'

RSpec.describe Driver, type: :model do

   #Association Rspec Testcases
   describe 'association' do

    context "has_and_belongs_to_many" do

      [:vehicles].each do |each|
        it each.to_s.humanize do
          association = Driver.reflect_on_association(each).macro
          expect(association).to be(:has_and_belongs_to_many)
        end
      end
    end
    

    context "has_many" do

      [:payments].each do |each|
        it each.to_s.humanize do
          association = Driver.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end


    context "has_many" do
      [:rides].each do |each|
        it each.to_s.humanize do
          association = Driver.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end


    context "has_many" do

      [:riders].each do |each|
        it each.to_s.humanize do
          association = Driver.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end


    context "has_one" do
      it "User" do
        association = Driver.reflect_on_association(:user).macro
        expect(association).to be(:has_one)
      end
    end



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
