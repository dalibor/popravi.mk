require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage posts" do
    click_link "Admin"
    click_link "Posts"
    click_link "New"
    check "Custom slug"
    fill_in "Slug", with: "my-custom-slug"
    fill_in "Title", with: "Hello world"
    fill_in "Content", with: "Post content"
    check "Published"
    click_button "Save"
    page.should have_content "Post was successfully created."
    page.should have_content "Test User"
    page.should have_content "Hello world"
    page.should have_content "my-custom-slug"
    click_link "Edit"
    fill_in "Content", with: "Post content 2"
    click_button "Save"
    page.should have_content "Post was successfully updated."
    page.should have_content "hello-world"
    page.should have_content "Hello world"
    page.should have_content "Post content 2"
    click_link "Delete"
    page.should have_content "Post was successfully destroyed."
    page.should_not have_content "Hello world"
  end
end
