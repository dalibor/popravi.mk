Feature: Admin can send problems to municipalities via email
  In order to inform municipalities about the reported problems
  As a admin
  I want to be able to send problems to municipalities via email

# problem1 is already reported
# problem4 is in municipality that don't have user in the system
# problem2, problem3 and problem5 should be sent
Background:
    Given a category exists with name: "category1"
    And a municipality exists with name: "municipality1"
    And a user exists with email: "municipality1@popravi.mk", municipality: the municipality
    And a problem exists with municipality: the municipality, category: the category, description: "problem1", sent_at: "2010-07-25 14:05:56"
    And a problem exists with municipality: the municipality, category: the category, description: "problem2"
    And a problem exists with municipality: the municipality, category: the category, description: "problem3"

    And a municipality exists with name: "municipality2"
    And a problem exists with municipality: the municipality, category: the category, description: "problem4"

    And a municipality exists with name: "municipality3"
    And a user exists with email: "municipality3@popravi.mk", municipality: the municipality
    And a problem exists with municipality: the municipality, category: the category, description: "problem5"

    And I am authenticated as admin
    And I am on the admin page
    And a clear email queue


Scenario: Filter problems by sent and unsent
    When I follow "Problems"
    Then I should see "problem1"
    And I should see "problem2"
    And I should see "problem3"
    And I should see "problem4"
    And I should see "problem5"

    When I follow "Sent"
    Then I should see "problem1"
    And I should not see "problem2"
    And I should not see "problem3"
    And I should not see "problem4"
    And I should not see "problem5"

    When I follow "Unsent"
    Then I should not see "problem1"
    And I should see "problem2"
    And I should see "problem3"
    And I should see "problem4"
    And I should see "problem5"

Scenario: Admin sends problems to municipalities via email
    When I follow "Problems"
    And I follow "Send problems to municipalities"
    Then I should see "Problems were successfullly sent to municipalities"
    And "municipality1@popravi.mk" should receive 1 email
    And "municipality2@popravi.mk" should receive 0 emails
    And "municipality3@popravi.mk" should receive 1 email

    When "municipality1@popravi.mk" opens the email
    Then I should see "[PopraviMK] Recently reported problems" in the email subject
    And I should see "Hello municipality1" in the email body
    And I should see "Following problems has been reported to your municipality" in the email body
    And I should see "problem2" in the email body
    And I should see "problem3" in the email body

    When I follow "municipality1 category1" in the email
    Then I should see "problem2"

    When "municipality3@popravi.mk" opens the email
    Then I should see "[PopraviMK] Recently reported problems" in the email subject
    And I should see "Hello municipality3" in the email body
    And I should see "Following problems has been reported to your municipality" in the email body
    And I should see "problem5" in the email body

    When I follow "municipality3 category1" in the email
    Then I should see "problem5"

    Given I am on the admin page
    When I follow "Problems"
    And I follow "Sent"
    Then I should see "problem1"
    And I should see "problem2"
    And I should see "problem3"
    And I should see "problem5"
    And I should not see "problem4"
