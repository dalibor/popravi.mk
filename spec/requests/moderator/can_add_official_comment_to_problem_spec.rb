require 'spec_helper'

describe "Moderator" do
  let(:municipality) { create(:municipality, name: "municipality1") }
  let(:moderator) { create(:user, municipality: municipality, email: 'moderator@popravi.mk') }

  before :each do
    create :problem, municipality: municipality, description: "problem1"
    login(moderator)
  end

  it "can add official comment to a problem" do
    visit root_path
    click_link "municipality1"
    fill_in "comment_content", with: "My official comment"
    click_button "Send"
    within ".official" do
      page.should have_content "My official comment"
    end
  end
end
