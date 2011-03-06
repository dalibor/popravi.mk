Feature: Visitor can report a problem
  In order to have problems near me fixed
  As a visitor
  I want to be able to report a problem

Scenario: Visitor can report a problem
  Given I am on the home page
  And category exists
  And municipality exists
  When I follow "Report a problem"
  And I fill in "problem_description" with "Problem description"
  And I fill in "problem_weight" with "7"
  And I attach the file "public/images/rails.png" to "problem_photo"
  And I change the value of the hidden field "problem[latitude]" to "42"
  And I change the value of the hidden field "problem[longitude]" to "21"
  And I fill in "problem_email" with "test_user@popravi.mk"
  And I select "Abandoned vehicles" from "problem_category_id"
  And I select "Butel" from "problem_municipality_id"
  And I press "problem_submit"
  Then I should see "Problem was successfully reported"
  And I should see "Problem description"
  And I should see "Weight: 7"
  And I should see "Butel"
  And I should see "Abandoned vehicles"
  And I should not see "Edit problem report"

Scenario: Automatically assigns user to problem when after problem is reported, user registers with same email
  Given I am on the home page
  And category exists
  And municipality exists
  When I follow "Report a problem"
  And I fill in "problem_description" with "Problem description"
  And I attach the file "public/images/rails.png" to "problem_photo"
  And I change the value of the hidden field "problem[latitude]" to "42"
  And I change the value of the hidden field "problem[longitude]" to "21"
  And I fill in "problem_email" with "test_user@popravi.mk"
  And I select "Abandoned vehicles" from "problem_category_id"
  And I select "Butel" from "problem_municipality_id"
  And I press "problem_submit"
  Then I should see "Problem was successfully reported"
  Given I signed up as "test_user@popravi.mk" with password "secretpass"
  And I confirmed my email address
  When I go to the sign in page
  And I fill in "Email" with "test_user@popravi.mk"
  And I fill in "Password" with "secretpass"
  And I press "Login"
  And I follow "My reports"
  Then I should see "Problem description"
