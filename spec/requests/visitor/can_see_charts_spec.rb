# Feature: Visitor can see charts
#   In order to view visual representation of charts
#   As a visitor
#   I want to be able to view charts

#   Scenario Outline: Visitor can see a chart
#     Given a problem exists with description: "Description 1"
#     And a problem exists with description: "Description 2"
#     And I am on the home page
#     click_link "Problems"
#     click_link "<chart_type>"
#     page.should have_content "<chart_title>"

#     Examples:
#       | chart_type   | chart_title              |
#       | Category     | Problems by category     |
#       | Municipality | Problems by municipality |
#       | Status       | Problems by status       |
