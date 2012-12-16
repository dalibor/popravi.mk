require 'spec_helper'

describe "User" do
  let(:user) { create :user  }

  before :each do
    municipality = create :municipality, name: "Municipality 1"
    create :problem, user: user, municipality: municipality
    login(user)
    visit root_path
    within ".main" do
      click_link "Municipality 1"
    end
  end

  it "can rate a problem" do
    # see error on create
    fill_in "rate_weight", with: "77"
    click_button "Rate"
    page.should have_content "is not included in the list"
    page.should_not have_content "Rate was successfully created"

    # create rate
    fill_in "rate_weight", with: "7"
    click_button "Rate"
    page.should have_content "Rate was successfully created"
    within ".rating" do
      page.should have_content "7.0"
    end
    within ".votes" do
      page.should have_content "1"
    end

    # see error on update
    fill_in "rate_weight", with: "33"
    click_button "Update rate"
    page.should have_content "is not included in the list"
    page.should_not have_content "Rate was successfully updated"

    # update rate
    fill_in "rate_weight", with: "3"
    click_button "Update rate"
    page.should have_content "Rate was successfully updated"
    within ".rating" do
      page.should have_content "3.0"
    end
    within ".votes" do
      page.should have_content "1"
    end
  end
end
