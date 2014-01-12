require 'spec_helper'

describe "Building pages" do

  subject { page }

  let(:landlord) { FactoryGirl.create(:landlord) }

  describe "show page" do
    let(:building) { FactoryGirl.create(:building, landlord: landlord) }

    before { visit landlord_building_path(landlord, building) }

    it { should have_content(building.address) }
    it { should have_content(building.zip_code) }
    it { should have_content(building.description) }
    it { should have_title(building.address) }
  end  

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

  describe "edit" do
    let(:building) { FactoryGirl.create(:building, landlord: landlord) }
    before { visit edit_landlord_building_path(landlord, building) }
    
    describe "page" do
      it { should have_content("Update building") }
      it { should have_title("Edit building") }

      describe "with invalid information" do
        before { click_button "Save changes" }

        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      let(:new_address)     { "123 yomommas st." }
      let(:new_zip_code)    { "60546" }
      let(:new_description) { "New description." }
      before do
        fill_in "Address",     with: new_address
        fill_in "Zip code",    with: new_zip_code
        fill_in "Description", with: new_description
      end

      it { should have_title(new_address) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(building.reload.address).to eq new_address } 
      specify { expect(building.reload.zip_code).to eq new_zip_code } 
      specify { expect(building.reload.description).to eq new_description } 
    end  
  end  
end
