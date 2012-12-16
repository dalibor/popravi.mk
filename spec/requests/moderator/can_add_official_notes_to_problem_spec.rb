require 'spec_helper'

describe "Moderator" do
  let(:municipality) { create(:municipality, name: "municipality1") }
  let(:moderator) { create(:user, municipality: municipality, email: 'moderator@popravi.mk') }

  before :each do
    create :problem, municipality: municipality, description: "problem1"
    login(moderator)
  end

  it "can enter official info to a problem" do
    click_link "Admin"
    click_link "Problems"
    click_link "problem1"
    click_link "Edit"
    fill_in "Official notes", with: "My official notes"
    click_button "Save"
    page.should have_content "Problem was successfully updated."
    page.should have_content "problem1"
    page.should have_content "My official notes"
    click_link "Edit"
    fill_in "Official notes", with: "My official notes 2"
    click_button "Save"
    page.should have_content "My official notes 2"
  end
end
