Feature: Visitor can report a problem
  In order to have problems near me fixed
  As a visitor
  I want to be able to report a problem

  Scenario: Reporting a problem when user is not logged in
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
    And I should not see "Edit problem report"

  Scenario: Reporting and editing a problem when user is logged in
    Given I am an authenticated user
    And I am on the home page
    And category exists
    And municipality exists
    When I follow "Report a problem"
    Then I should not see "Email"
    And I fill in "problem_description" with "Problem description"
    And I attach the file "public/images/rails.png" to "problem_photo"
    And I change the value of the hidden field "problem[latitude]" to "42"
    And I change the value of the hidden field "problem[longitude]" to "21"
    And I select "Abandoned vehicles" from "problem_category_id"
    And I select "Butel" from "problem_municipality_id"
    And I press "problem_submit"
    Then I should see "Problem was successfully reported"
    And I should see "Problem description"
    When I follow "Edit"
    And I fill in "problem_description" with "Problem description 2"
    And I press "problem_submit"
    Then I should see "Problem was successfully updated"
    And I should see "Problem description 2"
