require 'spec_helper'

describe "Visitor" do
  it "cannot rate a problem" do
    municipality = create :municipality, name: "Municipality 1"
    problem = create :problem, municipality: municipality
    visit root_path
    within ".main" do
      click_link "Municipality 1"
    end
    page.should_not have_css ".formtastic.rate"
    page.should_not have_content "Rate"
  end
end
