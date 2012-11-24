Given /^there are problems reported$/ do
  Factory(:problem, :description => 'problem1')
  Factory(:problem, :description => 'problem2')
  Factory(:problem, :description => 'problem3')
  Factory(:problem, :description => 'problem4')
  Factory(:problem, :description => 'problem5')
  Factory(:problem, :description => 'problem6')
end

Then /^I should see the last 5 problems$/ do
  page.should have_content('problem2')
  page.should have_content('problem3')
  page.should have_content('problem4')
  page.should have_content('problem5')
  page.should have_content('problem6')

  page.should_not have_content('problem1')
end

