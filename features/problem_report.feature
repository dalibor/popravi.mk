Feature: Report a problem
  In order to get street problems near me fixed
  As a user
  I want to be able to report a problem

  Scenario: Reporting a problem when user is not logged in
    Given I am on the home page
    And category exists
    And municipality exists
    When I follow "Пријави проблем"
    And I fill in "problem_description" with "Problem description"
    And I attach the file "public/images/rails.png" to "problem_photo"
    And I change the value of the hidden field "problem[latitude]" to "42"
    And I change the value of the hidden field "problem[longitude]" to "21"
    And I fill in "problem_email" with "test_user@popravi.mk"
    And I select "Abandoned vehicles" from "problem_category_id"
    And I select "Butel" from "problem_municipality_id"
    And I press "problem_submit"
    Then I should see "Проблемот е успешно пријавен"
    And I should not see "Edit problem report"

  Scenario: Reporting and editing a problem when user is logged in
    Given I am an authenticated user
    And I am on the home page
    And category exists
    And municipality exists
    When I follow "Пријави проблем"
    Then I should not see "Email"
    And I fill in "problem_description" with "Problem description"
    And I attach the file "public/images/rails.png" to "problem_photo"
    And I change the value of the hidden field "problem[latitude]" to "42"
    And I change the value of the hidden field "problem[longitude]" to "21"
    And I select "Abandoned vehicles" from "problem_category_id"
    And I select "Butel" from "problem_municipality_id"
    And I press "problem_submit"
    Then I should see "Проблемот е успешно пријавен"
    And I should see "Problem description"
    When I follow "Измени"
    And I fill in "problem_description" with "Problem description 2"
    And I press "problem_submit"
    Then I should see "Проблемот е успешно изменет"
    And I should see "Problem description 2"
