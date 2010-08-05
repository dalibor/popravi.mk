Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I signed up as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
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

Then /^my account should not be found$/ do
  User.find_by_email('test_user@popravi.mk').should be_nil
end

Given /^I am authenticated as admin$/ do
  admin_email = "admin@popravi.mk"
  admin_password = "admin@popravi.mk"

  user = User.new(:email => admin_email, :password => admin_password, :password_confirmation => admin_password)
  user.role = "admin"
  user.save!
  user.confirm!

  And %{I go to the sign in page}
  And %{I fill in "user_email" with "#{admin_email}"}
  And %{I fill in "user_password" with "#{admin_password}"}
  And %{I press "user_submit"}
end
