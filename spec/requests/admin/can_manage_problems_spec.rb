require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage problems" do
    create :category
    create :municipality
    click_link "Admin"
    click_link "Problems"
    click_link "New"
    fill_in "Description", with: "Problem description"
    fill_in "Official notes", with: "Problem official notes"
    attach_file "Photo", "public/images/rails.png"
    fill_in "Latitude", with: "42"
    fill_in "Longitude", with: "21"
    fill_in "Email", with: "test_user@popravi.mk"
    select "Abandoned vehicles", from: "problem_category_id"
    select "Butel", from: "problem_municipality_id"
    click_button "Save"
    page.should have_content "Problem was successfully created"
    page.should have_content "Problem description"
    page.should have_content "Problem official notes"
    click_link "Edit"
    fill_in "Description", with: "Problem description 2"
    fill_in "Official notes", with: "Problem official notes 2"
    click_button "Save"
    page.should have_content "Problem was successfully updated"
    page.should have_content "Problem description 2"
    page.should have_content "Problem official notes 2"
  end

  it "can change state of a problem" do
    create :problem, description: "problem1"
    click_link "Admin"
    click_link "Problems"
    page.should have_content "problem1"
    page.find("table.table tr[2] td[7]").text.should == "reported"
    click_link "Edit"
    select "solved", from: "Status"
    click_button "Save"
    page.should have_content "Problem was successfully updated"
    click_link "List"
    page.find("table.table tr[2] td[7]").text.should == "solved"
    click_link "Edit"
    select "approved", from: "Status"
    click_button "Save"
    page.should have_content "Problem was successfully updated"
    click_link "List"
    page.find("table.table tr[2] td[7]").text.should == "approved"
  end
end
