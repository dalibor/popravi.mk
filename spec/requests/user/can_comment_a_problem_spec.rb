require 'spec_helper'

describe "User" do
  let(:user) { create :user, name: "Authenticated User" }

  before :each do
    municipality = create :municipality, name: "Municipality 1"
    create :problem, user: user, municipality: municipality
    login(user)
    visit root_path
  end

  it "can comment a problem" do
    within ".main" do
      click_link "Municipality 1"
    end
    page.should_not have_content "#comment_name"
    page.should_not have_content "#comment_email"
    fill_in "comment_content", with: "My comment"
    click_button "Send"
    page.should have_content "Authenticated User"
    page.should have_content "My comment"
    page.should have_css ".comments img"
  end
end
