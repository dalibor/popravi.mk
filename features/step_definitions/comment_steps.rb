Then /^page should have "([^"]*)"$/ do |selector|
  page.should have_css(selector)
end

Then /^page should not have "([^"]*)"$/ do |selector|
  page.should_not have_css(selector)
end
