# Feature: Visitor can see list of municipalities
#   In order to see which municipalities has lots of problems
#   As a visitor
#   I want to be able to see list of municipalities with problems there

#   Scenario: Visitor can see list of municipalities
#     Given a region exists with name: "region1"
#     And a municipality exists with name: "municipality1", region: the region
#     And a problem exists with description: "problem1", municipality: the municipality
#     And a problem exists with description: "problem2", municipality: the municipality
#     And I am on the home page
#     page.should have_content "municipality1 2"
#     click_link "View all municipalities"
#     Then I should be on the municipalities page
#     page.should have_content "municipality1"
#     page.should have_content "Total problems 2"
#     page.should have_content "region1"
