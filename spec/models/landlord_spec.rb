require 'spec_helper'

describe Landlord do

  before { @landlord = Landlord.new(name: "Example Landlord", 
                                    email: "landlord@example.com",
                                    phone: "312-555-2345") }

  subject { @landlord }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:buildings) }

  it { should be_valid }

  describe "when name is not present" do
    before { @landlord.name = " " }
    it { should_not be_valid }
  end  

  describe "when email is not present" do
    before { @landlord.email = " " }
    it { should_not be_valid }
  end  
  
  describe "when phone is not present" do
    before { @landlord.phone = " " }
    it { should_not be_valid }
  end  

  describe "when name is too long" do
    before { @landlord.name = "a" * 51 }
    it { should_not be_valid }
  end  

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @landlord.email = invalid_address
        expect(@landlord).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @landlord.email = valid_address
        expect(@landlord).to be_valid
      end
    end
  end
end
