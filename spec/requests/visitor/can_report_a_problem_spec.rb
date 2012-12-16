require 'spec_helper'

describe "Visitor" do

  before :each do
    create :category
    create :municipality
    visit root_path
    click_link "Report"
  end

  it "can report a problem" do
    fill_in "Description", with: "Problem description"
    fill_in "problem_weight", with: "7"
    attach_file "Photo", "spec/fixtures/rails1.png"
    find("#problem_latitude").set("42")
    find("#problem_longitude").set("21")
    fill_in "problem_email", with: "test_user@popravi.mk"
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
    page.should_not have_content "Edit problem report"
  end

  it "automatically assigns user to problem when after problem is reported, user registers with same email" do
    fill_in "Description", with: "Problem description"
    attach_file "Photo", "spec/fixtures/rails1.png"
    find("#problem_latitude").set("42")
    find("#problem_longitude").set("21")
    fill_in "Email", with: "test_user@popravi.mk"
    select "Abandoned vehicles", from: "problem_category_id"
    select "Butel", from: "problem_municipality_id"
    click_button "Report a problem"
    page.should have_content "Problem was successfully reported"
    user = create :user, email: "test_user@popravi.mk", password: "password"
    click_link "Sign in"
    fill_in "Email", with: "test_user@popravi.mk"
    fill_in "Password", with: "password"
    click_button "Login"
    click_link "My reports"
    page.should have_content "Problem description"
  end
end
