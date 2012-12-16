require 'spec_helper'

describe "User" do
  let(:user) { create :user  }

  before :each do
    create :category
    create :municipality
  end

  it "can report a problem" do
    login(user)
    click_link "Report"
    page.should_not have_content "Email"
    fill_in "problem_description", with: "Problem description"
    fill_in "problem_weight", with: "7"
    attach_file "problem_photo", "spec/fixtures/rails1.png"
    find("#problem_latitude").set("42")
    find("#problem_longitude").set("21")
    select "Abandoned vehicles", from: "problem_category_id"
    select "Butel", from: "problem_municipality_id"
    click_button "Report a problem"
    page.should have_content "Problem was successfully reported"
    page.should have_content "Problem description"
    within ".weight" do
      page.should have_content "7"
    end
    page.should have_content "Butel"
    page.should have_content "Abandoned vehicles"
    click_link "Edit"
    fill_in "problem_description", with: "Problem description 2"
    click_button "Update problem"
    page.should have_content "Problem was successfully updated"
    page.should have_content "Problem description 2"
  end

  it "automatically assigns user to problem when problem is reported anonymously and user with same email exists" do
    user = create :user, email: "test_user@popravi.mk", password: 'password'
    visit root_path
    click_link "Report"
    fill_in "problem_description", with: "Problem description"
    attach_file "problem_photo", "spec/fixtures/rails1.png"
    find("#problem_latitude").set("42")
    find("#problem_longitude").set("21")
    fill_in "Email", with: "test_user@popravi.mk"
    select "Abandoned vehicles", from: "problem_category_id"
    select "Butel", from: "problem_municipality_id"
    click_button "Report a problem"
    page.should have_content "Problem was successfully reported"
    click_link "Sign in"
    fill_in "Email", with: "test_user@popravi.mk"
    fill_in "Password", with: "password"
    click_button "Login"
    click_link "My reports"
    page.should have_content "Problem description"
  end
end
