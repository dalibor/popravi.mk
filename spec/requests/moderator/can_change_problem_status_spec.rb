require 'spec_helper'

describe "Moderator" do
  let(:municipality) { create(:municipality, name: "municipality1") }
  let(:moderator) { create(:user, municipality: municipality, email: 'moderator@popravi.mk') }

  before :each do
    create :problem, municipality: municipality, description: "problem1"
    login(moderator)
  end

  it "can change problem status" do
    click_link "Admin"
    click_link "Problems"
    click_link "problem1"
    click_link "Edit"
    select "solved", from: "Status"
    click_button "Save"
    page.should have_content "Problem was successfully updated."
    page.should have_content "problem1"
    page.should have_content "solved"
  end
end
