# Feature: Visitor can report a problem
#   In order to have problems near me fixed
#   As a visitor
#   I want to be able to report a problem

#   Scenario: Visitor can report a problem
#     Given I am on the home page
#     And category exists
#     And municipality exists
#     click_link "Report"
#     fill_in "problem_description" with "Problem description"
#     fill_in "problem_weight" with "7"
#     And I attach the file "public/images/rails.png" to "problem_photo"
#     And I change the value of the hidden field "problem[latitude]" to "42"
#     And I change the value of the hidden field "problem[longitude]" to "21"
#     fill_in "problem_email" with "test_user@popravi.mk"
#     select "Abandoned vehicles" from "problem_category_id"
#     select "Butel" from "problem_municipality_id"
#     click_button "problem_submit"
#     page.should have_content "Problem was successfully reported"
#     page.should have_content "Problem description"
#     page.should have_content "7" within ".weight"
#     page.should have_content "Butel"
#     page.should have_content "Abandoned vehicles"
#     page.should_not have_content "Edit problem report"

#   Scenario: Automatically assigns user to problem when after problem is reported, user registers with same email
#     Given I am on the home page
#     And category exists
#     And municipality exists
#     click_link "Report"
#     fill_in "problem_description" with "Problem description"
#     And I attach the file "public/images/rails.png" to "problem_photo"
#     And I change the value of the hidden field "problem[latitude]" to "42"
#     And I change the value of the hidden field "problem[longitude]" to "21"
#     fill_in "problem_email" with "test_user@popravi.mk"
#     select "Abandoned vehicles" from "problem_category_id"
#     select "Butel" from "problem_municipality_id"
#     click_button "problem_submit"
#     page.should have_content "Problem was successfully reported"
#     Given I signed up as "test_user@popravi.mk" with password "secretpass"
#     And I confirmed my email address
#     When I go to the sign in page
#     fill_in "Email" with "test_user@popravi.mk"
#     fill_in "Password" with "secretpass"
#     click_button "Login"
#     click_link "My reports"
#     page.should have_content "Problem description"
