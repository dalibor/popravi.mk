FactoryGirl.define do
  factory :comment do
    content 'My comment'
    association :commentable, :factory => 'problem'
  end
end
