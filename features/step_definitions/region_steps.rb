Given /^there are no regions/ do
  Region.count != 0
end

Given /^there is region/ do
  Factory.create(:region)
end
