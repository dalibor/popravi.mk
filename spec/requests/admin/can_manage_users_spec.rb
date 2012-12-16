require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage users" do
    click_link "Admin"
    click_link "Users"
    click_link "New"
    fill_in "Name", with: "Test User 2"
    fill_in "E-mail", with: "test_user2@popravi.mk"
    fill_in "Password", with: "secretpass"
    fill_in "Password confirmation", with: "secretpass"
    click_button "Save"
    page.should have_content "User was successfully created"
    page.should have_content "Test User 2"
    click_link "Edit"
    fill_in "Name", with: "Test User 3"
    click_button "Save"
    page.should have_content "User was successfully updated"
    page.should have_content "Test User 3"
  end
end
