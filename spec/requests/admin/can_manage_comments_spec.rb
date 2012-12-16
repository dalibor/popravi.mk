require 'spec_helper'

describe "Admin" do
  let(:admin) { create(:admin, email: "admin@popravi.mk") }

  before :each do
    login(admin)
  end

  it "can manage comments" do
    problem = create(:problem)
    create(:comment, commentable: problem)
    click_link "Admin"
    click_link "Comments"
    click_link "Edit"
    fill_in "Comment", with: "Comment name 2"
    click_button "Save"
    page.should have_content "Comment was successfully updated"
    page.should have_content "Comment name 2"
  end
end
