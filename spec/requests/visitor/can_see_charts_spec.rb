require 'spec_helper'

describe "Visitor" do
  {
    'Category'     => 'Problems by category',
    'Municipality' => 'Problems by municipality',
    'Status'       => 'Problems by status'
  }.each do |chart_type, chart_title|
    it "can see a #{chart_type} chart" do
      problem = create :problem, description: "Description 1"
      problem = create :problem, description: "Description 2"
      visit root_path
      click_link "Problems"
      click_link chart_type
      page.should have_content chart_title
    end
  end
end
