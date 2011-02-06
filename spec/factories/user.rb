Factory.define :user do |f|
  f.name           "Test User"
  f.sequence(:email)  { |i| "user_#{i}@popravi.com" }
  f.password       "testuserpass"
end
