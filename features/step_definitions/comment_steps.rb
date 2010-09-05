Then /^page should have "([^"]*)"$/ do |selector|
  page.should have_css(selector)
end

Then /^page should not have "([^"]*)"$/ do |selector|
  page.should_not have_css(selector)
end

Given /^There are no comments/ do
  Comment.count == 0
end

Given /^There are comments/ do
  Factory.create(:comment, :user => @user)
end
