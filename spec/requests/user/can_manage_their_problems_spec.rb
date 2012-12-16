require 'spec_helper'

describe "User" do
  let(:user) { create :user  }

  before :each do
    login(user)
  end

  it "can list problems reported by me" do
    report_a_problem

    click_link "My reports"
    page.should have_content "Total: 1 problem"
    click_link "Butel"
    click_link "Edit"
    fill_in "Description", with: "New problem description"
    click_button "Update problem"
    page.should have_content "New problem description"
  end
end
