require 'spec_helper'

describe Tenant do
  
  let(:building) { FactoryGirl.create(:building) }
  before { @tenant = building.tenants.build(name: "John Tenant", 
                                email: "tenant@example.com",
                                phone: "555-234-3893") }

  subject { @tenant }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:building_id) }
  it { should respond_to(:building) }
  its(:building) { should eq building }

  it { should be_valid }

  describe "when name is not present" do
    before { @tenant.name = " " }
    it { should_not be_valid }
  end  

  describe "when email is not present" do
    before { @tenant.email = " " }
    it { should_not be_valid }
  end  

  describe "when phone is not present" do
    before { @tenant.phone = " " }
    it { should_not be_valid }
  end  

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @tenant.email = invalid_address
        expect(@tenant).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @tenant.email = valid_address
        expect(@tenant).to be_valid
      end
    end
  end
end
