require 'spec_helper'

describe "Visitor" do
  let(:user) { create :user  }

  before :each do
    region = create :region, name: "region1"
    municipality = create :municipality, name: "municipality1", region: region
    create :problem, user: user, municipality: municipality
    visit root_path
  end

  it "can comment a problem" do
    within ".main" do
      click_link "municipality1"
    end
    fill_in "Name", with: "My Name"
    fill_in "Email", with: "test_user@popravi.mk"
    fill_in "Comment", with: "My comment"
    click_button "Send"
    page.should have_content "My Name"
    page.should have_content "My comment"
  end
end
