require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage municipalities" do
    create(:region, name: "Skopski")
    click_link "Admin"
    click_link "Municipalities"
    click_link "New"
    fill_in "Name", with: "Municipality name"
    select "Skopski", from: "Region"
    click_button "Save"
    page.should have_content "Municipality was successfully created"
    page.should have_content "Municipality name"
    click_link "Edit"
    fill_in "Name", with: "Municipality name 2"
    click_button "Save"
    page.should have_content "Municipality was successfully updated"
    page.should have_content "Municipality name 2"
  end
end
