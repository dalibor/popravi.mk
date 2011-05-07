Feature: Manage attachments
  In order to have attachments
  As an editor
  I want to be able to manage attachments

  Scenario: Editor lists attachments in administration
    Given I am authenticated as admin
    And I follow "Admin"
    When I follow "Attachments"
    And I follow "New"
    And I fill in "Name" with "Attachment1"
    And I attach the file "spec/fixtures/rails1.png" to "Attachment"
    And I press "Save"
    Then I should see "Attachment was successfully created"
    And I should see "Attachment1"
    And I should see "rails1.png" in body

    When I follow "Edit"
    And I fill in "Name" with "Attachment2"
    And I attach the file "spec/fixtures/rails2.png" to "Attachment"
    And I press "Save"
    Then I should see "Attachment was successfully updated"
    And I should see "Attachment2"
    And I should see "rails2.png" in body

    When I follow "Delete"
    Then I should see "Attachment was successfully destroyed"
    And I should not see "Attachment2"
