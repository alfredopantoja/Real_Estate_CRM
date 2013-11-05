require 'spec_helper'

describe "Building pages" do

  subject { page }

  let(:landlord) { FactoryGirl.create(:landlord) }

  describe "building creation" do
    before { visit new_landlord_building_path(landlord) }

    describe "with invalid information" do

      it "should not create a building" do
        expect { click_button "Create new building" }.not_to change(Building, :count)
      end

      describe "error messages" do
        before { click_button "Create new building" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        fill_in "Address",     with: "145 Sunset blvd."
        fill_in "Zip code",    with: 60608
        fill_in "Description", with: "A super cool building"
      end

      it "should create a building" do
        expect { click_button "Create new building" }.to change(Building, :count).by(1)
      end
    end
  end  

  describe "building destruction" do
    
    it "should delete a building" do
      expect { click_link "delete" }.to change(Building, :count).by(-1)
    end
  end  
end
