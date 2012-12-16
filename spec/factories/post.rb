FactoryGirl.define do
  factory :post do
    title 'Hello world 1'
    content 'Post content'
    published true
    published_at '2010-01-01'
    association :user
  end
end
