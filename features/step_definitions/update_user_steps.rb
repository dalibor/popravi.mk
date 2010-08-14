Then /^the "([^"]*)" should contain "([^"]*)"$/ do |selector, value|
  find(selector).value.should =~ /#{value}/
end

