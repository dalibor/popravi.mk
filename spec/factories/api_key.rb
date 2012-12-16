FactoryGirl.define  do
  factory :api_key do |f|
    f.name 'Key name'
    f.key 'key'
    f.description 'Key description'
  end
end
