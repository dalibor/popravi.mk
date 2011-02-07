And /^I change the value of the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field_name, value|
  msg = "cannot set value of hidden field with name '#{field_name}'"
  xpath = %{//input[@type="hidden" and @name="#{field_name}"]}
  page.locate(:xpath, xpath, msg).set(value)
end


Given /^There are anonymouse problems$/ do
  Factory.create(:problem1)
  Factory.create(:problem3)
end

Given /^there are reported problems for searching$/ do
  problem1 = Factory.create(:problem1)
  Factory.create(:problem2)
  Factory.create(:problem3)
  Factory.create(:problem3, :category => problem1.category, :municipality => problem1.municipality, :description => "Description 4")
end

Given /^there are no problems/ do
  Problem.count == 0
end
