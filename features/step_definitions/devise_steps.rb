Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I signed up as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  @user = User.create!(:email => email, :password => password, :password_confirmation => password, :name => "Authenticated User", :avatar => File.open(File.join(Rails.root, 'public', 'images', 'rails.png')))
end

Given /^I confirmed my email address$/ do
  @user.confirm!
end

#Given /^my account is locked$/ do
  #@user.lock_access!
#end

Given /^I am an authenticated user$/ do
  email = 'test_user@popravi.mk'
  password = 'secretpass'

  Given %{I signed up as "#{email}" with password "#{password}"}
  And %{I confirmed my email address}
  And %{I go to the sign in page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "user_submit"}
end

Given /^I report a problem$/ do
  steps %Q{
    Given I am on the home page
    And category exists
    And municipality exists
    When I follow "Report"
    And I fill in "problem_description" with "Problem description"
    And I attach the file "public/images/rails.png" to "problem_photo"
    And I change the value of the hidden field "problem[latitude]" to "42"
    And I change the value of the hidden field "problem[longitude]" to "21"
    And I select "Abandoned vehicles" from "problem_category_id"
    And I select "Butel" from "problem_municipality_id"
    And I press "problem_submit"
    Then I should see "Problem was successfully reported"
  }
end

Then /^my account should not be found$/ do
  User.find_by_email('test_user@popravi.mk').should be_nil
end

Given /^I am authenticated as admin$/ do
  @user = Factory.build(:user, :email => 'admin@popravi.mk')
  @user.password_confirmation = @user.password
  @user.is_admin = true
  @user.save!
  @user.confirm!

  And %{I sign in as "#{@user.email}" with "#{@user.password}"}
end

Given /^I sign in as "([^\"]*)" with "([^\"]*)"$/ do |email, password|
  And %{I go to the sign in page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "user_submit"}
end
