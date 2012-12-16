FactoryGirl.define do
  factory :rate do
    association :user
    association :problem
    weight  5
  end
end
