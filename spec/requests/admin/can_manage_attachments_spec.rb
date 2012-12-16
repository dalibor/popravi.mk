require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage attachments" do
    click_link "Admin"
    click_link "Attachments"
    click_link "New"
    fill_in "Name", with: "Attachment1"
    attach_file "Attachment", "spec/fixtures/rails1.png"
    click_button "Save"
    page.should have_content "Attachment was successfully created"
    page.should have_content "Attachment1"
    page.should have_content "rails1.png"

    click_link "Edit"
    fill_in "Name", with: "Attachment2"
    attach_file "Attachment", "spec/fixtures/rails2.png"
    click_button "Save"
    page.should have_content "Attachment was successfully updated"
    page.should have_content "Attachment2"
    page.should have_content "rails2.png"

    click_link "Delete"
    page.should have_content "Attachment was successfully destroyed"
    page.should_not have_content "Attachment2"
  end
end
