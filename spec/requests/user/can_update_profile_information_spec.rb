require 'spec_helper'

describe "User" do
  let(:user) { create :user }

  before :each do
    login(user)
    create :category
    create :municipality
    visit root_path
    click_link "Report"
  end

  it "Change user and confirm email" do
    click_link "Settings"
    fill_in "user_email", with: "new_test_user@popravi.mk"
    fill_in "user_name", with: "My Name"
    attach_file "user_avatar", "spec/fixtures/rails1.png"
    fill_in "Password", with: "newpass"
    fill_in "Password confirmation", with: "newpass"
    fill_in "Current password", with: "password"
    click_button "Update"
    page.should have_content "You updated your account successfully."
    # find_field("#user_name").should == "My Name"
    # page.should have_css ".edit_avatar img"
  end
end
