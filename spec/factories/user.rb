FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email) { |i| "user_#{i}@popravi.com" }
    password 'password'
    confirmed_at { Time.now }
  end

  factory :admin, class: User, parent: :user do
    sequence(:email) { |i| "admin_#{i}@popravi.com" }
    is_admin true
  end
end
