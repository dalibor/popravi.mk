require 'spec_helper'

describe "Moderator" do
  let(:municipality) { create(:municipality, name: "municipality1") }
  let(:moderator) { create(:user, municipality: municipality, email: 'moderator@popravi.mk') }

  before :each do
    problem = create :problem, municipality: municipality, description: "problem1"
    create :comment, commentable: problem, user: moderator
    login(moderator)
  end

  it "can edit their comment" do
    click_link "Admin"
    click_link "Comments"
    page.should have_content "My comment"
    click_link "Edit"
    fill_in "Comment", with: "My edited comment"
    click_button "Save"
    page.should have_content "Comment was successfully updated."
    page.should have_content "My edited comment"
    click_link "Edit"
    fill_in "Comment", with: "My edited comment 2"
    click_button "Save"
    page.should have_content "Comment was successfully updated."
    page.should have_content "My edited comment 2"
    click_link "List"
    click_link "Delete"
    page.should have_content "Comment was successfully deleted."
    page.should_not have_content "My edited comment 2"
  end
end
