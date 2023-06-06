require 'rails_helper'

RSpec.describe User, type: :model do

  #Association Rspec Testcases
  describe 'association' do

    context "belongs_to" do
      let!(:user) {create(:user , :for_rider)}
      it "rider is true" do
        expect(user.userable).to be_an_instance_of(Rider)
      end
    end

    context "belongs_to" do
      let!(:user) {create(:user , :for_driver)}
      it "driver is true" do
        expect(user.userable).to be_an_instance_of(Driver)
      end
    end



  end

  #Validations Rspec Testcases
  describe "name" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , name: "Ragul")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:name)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , name: nil)}
      it "throws error" do
        expect(user.errors).to include(:name)
      end
    end

  end

  describe "door_no" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , door_no: "59-A")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:door_no)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , door_no: nil)}
      it "throws error" do
        expect(user.errors).to include(:door_no)
      end
    end

  end

  describe "street" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , street: "Gandhi Nagar")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:street)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , street: nil)}
      it "throws error" do
        expect(user.errors).to include(:street)
      end
    end

  end

  describe "city" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , city: "Coimbatore")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:city)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , city: nil)}
      it "throws error" do
        expect(user.errors).to include(:city)
      end
    end

  end

  describe "district" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , district: "Coimbatore")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:district)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , district: nil)}
      it "throws error" do
        expect(user.errors).to include(:district)
      end
    end

  end

  describe "state" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , state: "Tamil Nadu")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:state)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , state: nil)}
      it "throws error" do
        expect(user.errors).to include(:state)
      end
    end

  end

  describe "role" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , role: "Rider")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:role)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , role: nil)}
      it "throws error" do
        expect(user.errors).to include(:role)
      end
    end

  end

  describe "pincode" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , pincode: 628502)}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:pincode)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , pincode: nil)}
      it "throws error" do
        expect(user.errors).to include(:pincode)
      end
    end

    context "when value exceeds 6 digits" do
      let(:user) {build(:user , pincode: 6228526)}
      it "throws error" do
        expect(user.errors).to include(:pincode)
      end
    end

    context "when value preceeds 6 digits" do
      let(:user) {build(:user , pincode: 6285)}
      it "throws error" do
        expect(user.errors).to include(:pincode)
      end
    end

    context "when value is alphabetic" do
      let(:user) {build(:user , pincode: "abcde")}
      it "throws error" do
        expect(user.errors).to include(:pincode)
      end
    end

    context "when value is alpha_numeric" do
      let(:user) {build(:user , pincode: "abcde12345")}
      it "throws error" do
        expect(user.errors).to include(:pincode)
      end
    end
    
  end

  describe "mobile_no" do

    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user , mobile_no: "9994406107")}
      it "doesnt throw any error" do
        expect(user.errors).to_not include(:mobile_no)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user , mobile_no: nil)}
      it "throws error" do
        expect(user.errors).to include(:mobile_no)
      end
    end

    context "when value exceeds 10 digits" do
      let(:user) {build(:user , mobile_no: "99944061071")}
      it "throws error" do
        expect(user.errors).to include(:mobile_no)
      end
    end

    context "when value preceeds 10 digits" do
      let(:user) {build(:user , mobile_no: "99944061")}
      it "throws error" do
        expect(user.errors).to include(:mobile_no)
      end
    end

    context "when value is alphabetic" do
      let(:user) {build(:user , mobile_no: "abcde")}
      it "throws error" do
        expect(user.errors).to include(:mobile_no)
      end
    end

    context "when value is alpha_numeric" do
      let(:user) {build(:user , mobile_no: "abcde12345")}
      it "throws error" do
        expect(user.errors).to include(:mobile_no)
      end
    end
    
  end

  #Rspec Testcases for methods
  describe "methods" do

    context "when rider is created" do
      let(:user) {build(:user)}
      it 'user.rider? return true' do
        
        expect(user.rider?).to eq(true)
      end

    end

    context "when driver is created" do
      let(:user) {build(:user , :for_driver)}
      it 'user.rider? return false' do
        expect(user.rider?).to eq(false)
      end

    end

    context "when driver is created" do
      let(:user) {build(:user , :for_driver)}
      it 'user.driver? return true' do
        expect(user.driver?).to eq(true)
      end

    end

    context "when rider is created" do
      let(:user) {build(:user , :for_rider)}
      it 'user.driver? return false' do
        expect(user.driver?).to eq(false)
      end

    end
    
  end


end
