Given /^posts exists$/ do
  user = User.first
  post = user ? Factory.create(:post, :user => user) : Factory.create(:post) # if there is already user in db, assign that user
  Factory.create(:post, :user => post.user, :published_at => "2010-03-01", :title => "Hello world 2")
end

Given /^there are no posts/ do
  Post.count == 0
end

Given /^there are no categories$/ do
  Category.count == 0
end

Then /^page should have "([^"]*)"$/ do |selector|
  page.should have_css(selector)
end

Then /^page should not have "([^"]*)"$/ do |selector|
  page.should_not have_css(selector)
end

Given /^There are no comments/ do
  Comment.count == 0
end

Given /^there are no countries/ do
  Country.count != 0
end

Given /^there is country$/ do
  Factory.create(:country)
end

Given /^there are no municipalities/ do
  Municipality.count != 0
end

And /^I change the value of the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field_name, value|
  msg = "cannot set value of hidden field with name '#{field_name}'"
  xpath = %{//input[@type="hidden" and @name="#{field_name}"]}
  find(:xpath, xpath).set(value)
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

Given /^there are no regions/ do
  Region.count != 0
end

Given /^there is region/ do
  Factory.create(:region)
end

Then /^the "([^"]*)" should contain "([^"]*)"$/ do |selector, value|
  find(selector).value.should =~ /#{value}/
end

