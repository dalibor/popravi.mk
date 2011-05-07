Feature: User can rate a problem
  In order to prioritize problems
  As a user
  I want to be able to set rate for a problem

  Scenario: User can create, update and see errors during rating a problem
    Given a user exists
    And a municipality exists with name: "Municipality 1"
    And a problem exists with user: the user, municipality: the municipality
    And I am an authenticated user
    And I am on the home page
    When I follow "Municipality 1" within ".main"

    # see error on create
    When I fill in "rate_weight" with "77"
    And I press "rate_submit"
    Then I should see "is not included in the list"
    And I should not see "Rate was successfully created"

    # create rate
    When I fill in "rate_weight" with "7"
    And I press "rate_submit"
    Then I should see "Rate was successfully created"
    Then I should see "7.0" within ".rating"
    And I should see "1" within ".votes"

    # see error on update
    When I fill in "rate_weight" with "33"
    And I press "rate_submit"
    Then I should see "is not included in the list"
    And I should not see "Rate was successfully updated"
    
    # update rate
    And I fill in "rate_weight" with "3"
    When I press "rate_submit"
    Then I should see "Rate was successfully updated"
    Then I should see "3.0" within ".rating"
    And I should see "1" within ".votes"
