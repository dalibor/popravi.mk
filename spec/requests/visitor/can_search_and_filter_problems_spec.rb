require 'spec_helper'

describe "Visitor" do
  it "can search problems by description" do
    problem = create :problem, description: "Description 1"
    problem = create :problem, description: "Description 2"
    visit root_path
    click_link "Problems"
    fill_in "Search", with: "Description 1"
    click_button "Search"
    page.should have_content "Total found: 1 problem"
    page.should have_content "Description 1"
    page.should_not have_content "Description 2"
  end

  it "can filter problems by category" do
    category1 = create :category, name: "Category 1"
    problem = create :problem, description: "Problem from category 1", category: category1
    category2 = create :category, name: "Category 2"
    problem  = create :problem, description: "Problem from category 2", category: category2
    visit root_path
    click_link "Problems"
    select "Category 1", from: "Category"
    click_button "Search"
    page.should have_content "Total found: 1 problem"
    page.should have_content "Problem from category 1"
    page.should_not have_content "Problem from category 2"
  end

  it "can filter problems by municipality" do
    municipality1 = create :municipality, name: "Municipality 1"
    problem = create :problem, description: "Problem from municipality 1", municipality: municipality1
    municipality2 = create :municipality, name: "Municipality 2"
    problem2 = create :problem, description: "Problem from municipality 2", municipality: municipality2
    visit root_path
    click_link "Problems"
    select "Municipality 1", from: "Municipality"
    click_button "Search"
    page.should have_content "Total found: 1 problem"
    page.should have_content "Problem from municipality 1"
    page.should_not have_content "Problem from municipality 2"
  end

  it "can filter problems by status" do
    municipality1 = create :municipality, name: "Municipality 1"
    problem = create :problem, description: "Problem from municipality 1", municipality: municipality1
    problem.update_attribute(:status, "approved")
    municipality2 = create :municipality, name: "Municipality 2"
    problem = create :problem, description: "Problem from municipality 2", municipality: municipality2
    problem.update_attribute(:status, "activated")
    visit root_path
    click_link "Problems"
    select "approved", from: "Status"
    click_button "Search"
    page.should have_content "Total found: 1 problem"
    page.should have_content "Problem from municipality 1"
    page.should_not have_content "Problem from municipality 2"
  end

  it "can search problems by date" do
    [
      ['July',   '2010', 'Problem 1', 'Problem 2'],
      ['July',   '',     'Problem 1', 'Problem 2'],
      ['August', '2011', 'Problem 2', 'Problem 1'],
      ['August', '',     'Problem 2', 'Problem 1'],
      ['',       '2010', 'Problem 1', 'Problem 2'],
      ['',       '2011', 'Problem 2', 'Problem 1']
    ].each do |row|
      municipality1 = create :municipality, name: "Municipality 1"
      problem = create :problem, description: "Problem 1", municipality: municipality1, created_at: "2010-07-20 20:25:49"
      municipality2 = create :municipality, name: "Municipality 2"
      problem = create :problem, description: "Problem 2", municipality: municipality2, created_at: "2011-08-20 20:25:49"
      visit root_path
      click_link "Problems"
      select row[0], from: "Month"
      select row[1], from: "Year"
      click_button "Search"
      page.should have_content row[2]
      page.should_not have_content row[3]
    end
  end
end
