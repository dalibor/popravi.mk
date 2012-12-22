photo = File.open("spec/fixtures/rails.png", 'r')

FactoryGirl.define do
  factory :problem do
    description 'Problem description'
    photo photo
    longitude '21'
    latitude '41'
    association :category
    association :municipality
    status 'reported'
    association :user
  end
end
