Feature: Visitor can receive email instructions
  In order to correct issues with my account
  As a visitor
  I want to be able to receive instructions via email

  Scenario: Resend email confirmation instructions and activate account
    Given I am not authenticated
    And I signed up as "test_user@popravi.mk" with password "secretpass"
    And I go to the resend confirmation instructions page
    When I fill in "Email" with "test_user@popravi.mk"
    And I press "Send confirmation"
    Then I should see "You will receive an email with instructions about how to confirm your account in a few minutes."
    And I should receive 2 emails
    When I open the email with subject "Confirmation instructions"
    When I follow "Confirm my account" in the email
    Then I should see "Your account was successfully confirmed. You are now signed in."

  Scenario: Send password change instructions and change password
    Given I am not authenticated
    And I signed up as "test_user@popravi.mk" with password "secretpass"
    And I confirmed my email address
    And I go to the send password instructions page
    When I fill in "user_email" with "test_user@popravi.mk"
    And I press "user_submit"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."
    And I should receive 2 emails
    When I open the email with subject "Reset password instructions"
    Then I should see "Reset password instructions" in the email subject
    When I follow "Change my password" in the email
    Then I should see "Change your password"
    When I fill in "Password" with "newsecretpass"
    And I fill in "Password confirmation" with "newsecretpass"
    When I press "Change my password"
    Then I should see "Your password was changed successfully. You are now signed in."

    #Scenario: Resend unlock account instructions
    #Given I am not authenticated
    #And I signed up as "johndoe3@example.com" with password "secretpass"
    #And I confirmed my email address
    #And my account is locked
    #And I go to the send unlock instructions page
    #When I fill in "user_email" with "johndoe3@example.com"
    #And I press "Resend"
    #Then I should see "instructions about how to unlock your account"
    #And an email should be sent to "johndoe3@example.com" with "Unlock my account" in the body
