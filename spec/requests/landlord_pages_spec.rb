require 'spec_helper'

describe "Landlord pages" do

  subject { page }

  describe "show page" do
    let(:landlord) { FactoryGirl.create(:landlord) }
    before { visit landlord_path(landlord) }

    it { should have_content(landlord.name) }
    it { should have_title(landlord.name) }
  end  

  describe "new page" do
    before { visit new_landlord_path }

    it { should have_content('Create new landlord') }
    it { should have_title(full_title('Create new landlord')) }
  end  

  describe "new landlord signup" do
    before { visit new_landlord_path }

    let(:submit) { "Create new landlord" }

    describe "with invalid information" do
      it "should not create a landlord" do
        expect { click_button submit }.not_to change(Landlord, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",  with: "Example Landlord"
        fill_in "Email", with: "landlord@example.com"
        fill_in "Phone", with: "312-555-4857"
      end  

      it "should create a landlord" do
        expect { click_button submit }.to change(Landlord, :count).by(1)
      end
    end
  end  
end
