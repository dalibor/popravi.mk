require 'spec_helper'

describe "Visitor" do
  it "can see problem promotion on home page" do
    region = create :region, name: "region1"
    municipality = create :municipality, name: "municipality1", region: region
    problem = create :problem, description: "problem1", municipality: municipality, status: "solved"
    problem.update_attribute(:status, "solved")
    visit root_path
    page.should have_content "municipality1 solved a problem"
  end
end
