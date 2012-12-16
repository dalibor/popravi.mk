require 'spec_helper'

describe "Visitor" do
  it "can search problems by description" do
    municipality = create :municipality, name: "municipality1"
    create :problem, description: "Problem1", municipality: municipality
    create :problem, description: "Problem2", municipality: municipality
    visit root_path
    click_link "municipality1 2"
    current_path.should == municipality_root_path(municipality.slug)
    page.should have_content "Problem1"
    page.should have_content "Problem2"
    fill_in "Search", with: "Problem1"
    click_button "Search"
    current_path.should == municipality_problems_path(municipality.slug)
    page.should have_content "Total found: 1 problem"
    page.should have_content "Problem1"
    page.should_not have_content "Problem2"
  end

  it "can filter problems by category" do
    municipality = create :municipality, name: "municipality1"
    category1 = create :category, name: "Category1"
    problem = create :problem, description: "Problem1", category: category1, municipality: municipality
    category2 = create :category, name: "Category2"
    problem = create :problem, description: "Problem2", category: category2, municipality: municipality
    visit root_path
    click_link "municipality1 2"
    current_path.should == municipality_root_path(municipality.slug)
    page.should have_content "Problem1"
    page.should have_content "Problem2"
    select "Category1", from: "Category"
    click_button "Search"
    current_path.should == municipality_problems_path(municipality.slug)
    page.should have_content "Total found: 1 problem"
    page.should have_content "Problem1"
    page.should_not have_content "Problem2"
  end

  it "can filter problems by status" do
    municipality = create :municipality, name: "municipality1"
    problem = create :problem, description: "Problem1", municipality: municipality
    problem.update_attribute(:status, "approved")
    problem = create :problem, description: "Problem2", municipality: municipality
    problem.update_attribute(:status, "activated")
    visit root_path
    click_link "municipality1 2"
    current_path.should == municipality_root_path(municipality.slug)
    page.should have_content "Problem1"
    page.should have_content "Problem2"
    select "approved", from: "Status"
    click_button "Search"
    current_path.should == municipality_problems_path(municipality.slug)
    page.should have_content "Total found: 1 problem"
    page.should have_content "Problem1"
    page.should_not have_content "Problem2"
  end

  it "can search problems by date" do
    [
      ['July',   '2010', 'Problem1', 'Problem2'],
      ['July',   '',     'Problem1', 'Problem2'],
      ['August', '2011', 'Problem2', 'Problem1'],
      ['August', '',     'Problem2', 'Problem1'],
      ['',       '2010', 'Problem1', 'Problem2'],
      ['',       '2011', 'Problem2', 'Problem1']
    ].each do |row|
      municipality = create :municipality, name: "municipality1"
      problem = create :problem, description: "Problem1", municipality: municipality, created_at: "2010-07-20 20:25:49"
      problem = create :problem, description: "Problem2", municipality: municipality, created_at: "2011-08-20 20:25:49"
      visit root_path
      click_link "municipality1 2"
      current_path.should == municipality_root_path(municipality.slug)
      page.should have_content "Problem1"
      page.should have_content "Problem2"
      select row[0], from: "Month"
      select row[1], from: "Year"
      click_button "Search"
      current_path.should == municipality_problems_path(municipality.slug)
      page.should have_content "Total found: 1 problem"
      page.should have_content row[2]
      page.should_not have_content row[3]
    end
  end
end
