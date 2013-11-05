require 'spec_helper'

describe "Landlord pages" do

  subject { page }
  
  describe "index" do
    before { visit landlords_path }

    it { should have_title('All landlords') }
    it { should have_content('All landlords') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:landlord) } }
      after(:all)  { Landlord.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each landlord" do
        Landlord.all.each do |landlord|
          expect(page).to have_selector('li', text: landlord.name)
        end
      end
    end  

    describe "delete links" do
      before { visit landlords_path }

      it { should have_link('delete', href: landlord_path(Landlord.first)) }

      it "should be able to delete another user" do
        expect do
          click_link('delete', match: :first)
        end.to change(Landlord, :count).by(-1)
      end
    end  
  end

  describe "show page" do
    let(:landlord) { FactoryGirl.create(:landlord) }
    let!(:building1) { FactoryGirl.create(:building, address: "123 main st.", 
                                                     zip_code: 60402,
                                                     description: "a beautiful building") }
    let!(:building2) { FactoryGirl.create(:building, address: "332 whipple st.", 
                                                     zip_code: 60623,
                                                     description: "a beautiful building") }

    before { visit landlord_path(landlord) }

    it { should have_content(landlord.name) }
    it { should have_title(landlord.name) }

    describe "buildings" do
      it { should have_content(building1.address) }
      it { should have_content(building2.address) }
      it { should have_content(landlord.buildings.count) }
    end  
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

  describe "edit" do
    let(:landlord) { FactoryGirl.create(:landlord) }
    before { visit edit_landlord_path(landlord) }

    describe "page" do
      it { should have_content("Update landlord") }
      it { should have_title("Edit landlord") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      let(:new_phone) { "555-555-5555" }
      before do
        fill_in "Name",   with: new_name
        fill_in "Email",   with: new_email
        fill_in "Phone",   with: new_phone
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(landlord.reload.name).to eq new_name }
      specify { expect(landlord.reload.email).to eq new_email }
      specify { expect(landlord.reload.phone).to eq new_phone }
    end  
  end  
end
