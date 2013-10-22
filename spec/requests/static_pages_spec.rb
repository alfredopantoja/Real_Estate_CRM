require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Real Estate CRM'" do
      visit '/static_pages/home'
      expect(page).to have_content('Real Estate CRM')
    end
  end  
end
