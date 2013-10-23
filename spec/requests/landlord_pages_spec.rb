require 'spec_helper'

describe "Landlord pages" do

  subject { page }

  describe "new page" do
    before { visit new_landlord_path }

    it { should have_content('Create new landlord') }
    it { should have_title(full_title('Create new landlord')) }
  end  
end
