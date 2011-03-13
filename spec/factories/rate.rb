Factory.define :rate do |f|
  f.association :user
  f.association :problem
  f.weight  5
end
