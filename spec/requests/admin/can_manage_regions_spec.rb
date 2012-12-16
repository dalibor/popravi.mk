require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage regions" do
    click_link "Admin"
    create :country, name: "Macedonia"
    click_link "Regions"
    click_link "New"
    fill_in "Name", with: "Region name"
    select "Macedonia", from: "Country"
    click_button "Save"
    page.should have_content "Region was successfully created"
    page.should have_content "Region name"
    click_link "Edit"
    fill_in "Name", with: "Region name 2"
    click_button "Save"
    page.should have_content "Region was successfully updated"
    page.should have_content "Region name 2"
  end
end
