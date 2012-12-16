require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage API keys" do
    click_link "Admin"
    click_link "API Keys"
    click_link "New"
    fill_in "Name", with: "API Key 1"
    fill_in "Key", with: "y3i21o"
    fill_in "Description", with: "Key 1 description"
    click_button "Save"
    page.should have_content "Api key was successfully created"
    page.should have_content "API Key 1"
    page.should have_content "y3i21o"
    page.should have_content "Key 1 description"
    click_link "Edit"
    fill_in "Name", with: "API Key 2"
    click_button "Save"
    page.should have_content "Api key was successfully updated"
    page.should have_content "API Key 2"
  end
end
