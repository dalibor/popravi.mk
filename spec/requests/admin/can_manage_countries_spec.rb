require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage countries" do
    click_link "Admin"
    click_link "Countries"
    click_link "New"
    fill_in "Name", with: "Country name"
    click_button "Save"
    page.should have_content "Country was successfully created"
    page.should have_content "Country name"
    click_link "Edit"
    fill_in "Name", with: "Country name 2"
    click_button "Save"
    page.should have_content "Country was successfully updated"
    page.should have_content "Country name 2"
  end
end
