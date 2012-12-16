require 'spec_helper'

describe "Visitor" do
  it "can see problems on municipality page" do
    region = create :region, name: "region1"
    municipality = create :municipality, name: "Municipality1", region: region
    problem = create :problem, description: "problem1", municipality: municipality
    visit root_path
    page.should have_content "Municipality1 1"
    click_link "View all municipalities"
    click_link "Municipality1"
    click_link "Municipality1"
    page.should have_content "problem1"
  end
end
