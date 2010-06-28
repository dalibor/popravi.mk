Feature: Email instructions
  In order to correct issues with my account
  As a user
  I want to receive instructions via email
 
  Scenario: Resend email confirmation instructions and activate account
    Given I am not authenticated
    And I signed up as "test_user@popravi.mk" with password "secretpass"
    And I go to the resend confirmation instructions page
    When I fill in "user_email" with "test_user@popravi.mk"
    And I press "Resend"
    Then I should see "instructions about how to confirm your account"
    And I should receive 2 emails
    When I open the email with subject "Confirmation instructions"
    Then I should see "Confirmation instructions" in the email subject
    When I follow "Confirm my account" in the email
    Then I should see "Signed in as test_user@popravi.mk"

  Scenario: Send password change instructions and change password
    Given I am not authenticated
    And I signed up as "test_user@popravi.mk" with password "secretpass"
    And I confirmed my email address
    And I go to the send password instructions page
    When I fill in "user_email" with "test_user@popravi.mk"
    And I press "Send"
    Then I should see "instructions about how to reset your password"
    And I should receive 2 emails
    When I open the email with subject "Reset password instructions"
    Then I should see "Reset password instructions" in the email subject
    When I follow "Change my password" in the email
    Then I should see "Change your password"
    When I fill in "user_password" with "newsecretpass"
    And I fill in "user_password_confirmation" with "newsecretpass"
    When I press "Change my password"
    Then I should see "Signed in as test_user@popravi.mk"

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
