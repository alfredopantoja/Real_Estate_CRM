require 'spec_helper'

describe Building do

  before { @building = Building.new(address: "2316 s. whipple", 
                                    zip_code: 60623, 
                                    description: "a lovely brownstone") }

  subject { @building }

  it { should respond_to(:address) }
  it { should respond_to(:zip_code) }
  it { should respond_to(:description) }
  it { should respond_to(:landlord_id) }

  it { should be_valid }

  describe "when address is not present" do
    before { @building.address = " " }
    it { should_not be_valid }
  end  

  describe "when zip code is not present" do
    before { @building.zip_code = " " }
    it { should_not be_valid }
  end  

  describe "when zip code is too long" do
    before { @building.zip_code = 123456 }
    it { should_not be_valid }
  end

  describe "when zip code is too shot" do
    before { @building.zip_code = 1234 }
    it { should_not be_valid }
  end
end
