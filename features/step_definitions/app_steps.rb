#Given /^posts exists$/ do
  #user = User.first
  #post = user ? Factory.create(:post, :user => user) : Factory.create(:post) # if there is already user in db, assign that user
  #Factory.create(:post, :user => post.user, :published_at => "2010-03-01", :title => "Hello world 2")
#end

Then /^page should have "([^"]*)"$/ do |selector|
  page.should have_css(selector)
end

Then /^page should not have "([^"]*)"$/ do |selector|
  page.should_not have_css(selector)
end

And /^I change the value of the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field_name, value|
  msg = "cannot set value of hidden field with name '#{field_name}'"
  xpath = %{//input[@type="hidden" and @name="#{field_name}"]}
  find(:xpath, xpath).set(value)
end

Then /^the "([^"]*)" should contain "([^"]*)"$/ do |selector, value|
  find(selector).value.should =~ /#{value}/
end

Then /^debug$/ do
  $page = page # to access the capybara page for debugging
  debugger
end

Then /^column "([^"]*)" row "([^"]*)" should have text "([^"]*)"$/ do |column, row, text|
  page.find("table.table tr[#{row}] td[#{column}]").text.should == text
end

Given /^now is "([^"]*)"$/ do |time|
  Time.stub(:now).and_return(Time.parse(time))
end

Given /^([^"]*) is solved$/ do |name|
  problem = model(name)
  problem.approve!
  problem.activate!
  problem.solve!
end
