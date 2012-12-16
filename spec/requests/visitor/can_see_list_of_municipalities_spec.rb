require 'spec_helper'

describe "Visitor" do
  it "can see list of municipalities" do
    region = create :region, name: "region1"
    municipality = create :municipality, name: "municipality1", region: region
    create :problem, description: "problem1", municipality: municipality
    create :problem, description: "problem2", municipality: municipality
    visit root_path
    page.should have_content "municipality1 2"
    click_link "View all municipalities"
    page.should have_content "municipality1"
    page.should have_content "Total problems 2"
    page.should have_content "region1"
  end
end
