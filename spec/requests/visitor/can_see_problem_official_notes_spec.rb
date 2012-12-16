require 'spec_helper'

describe "Visitor" do
  it "can see problem's official notes" do
    municipality = create :municipality, name: "Municipality 1"
    problem = create :problem, municipality: municipality, description: "problem1", official_notes: "problem1 official notes"
    visit root_path
    click_link "Municipality 1"
    page.should have_content "problem1"
    page.should have_content "problem1 official notes"
  end
end
