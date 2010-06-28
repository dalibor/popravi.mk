Given /^there are no countries/ do
  Country.count != 0
end

Given /^there is country$/ do
  Factory.create(:country)
end
