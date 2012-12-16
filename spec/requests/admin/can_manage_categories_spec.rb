require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage attachments" do
    click_link "Admin"
    click_link "Categories"
    click_link "New"
    fill_in "Name", with: "Category name"
    click_button "Save"
    page.should have_content "Category was successfully created"
    page.should have_content "Category name"
    click_link "Edit"
    fill_in "Name", with: "Category name 2"
    click_button "Save"
    page.should have_content "Category was successfully updated"
    page.should have_content "Category name 2"
  end

  it "can change position of category" do
    create :category, name: "Category 1", position: "1"
    create :category, name: "Category 2", position: "2"
    click_link "Admin"
    click_link "Categories"
    within ".odd" do
      page.should have_content "Category 1"
    end
    within ".even" do
      page.should have_content "Category 2"
    end
    click_link "Move up"
    within ".even" do
      page.should have_content "Category 1"
    end
    within ".odd" do
      page.should have_content "Category 2"
    end
  end
end
