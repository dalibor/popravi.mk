photo = File.open("public/images/rails.png", 'r')

Factory.define :problem do |f|
  f.association :user
  f.association :category
  f.association :municipality
  f.description "Problem description"
  f.photo photo
  f.longitude "21"
  f.latitude "41"
end

Factory.define :anonymous_problem, :class => Problem do |f|
  f.association :category
  f.association :municipality
  f.description "Problem description"
  f.photo photo
  f.longitude   "21"
  f.latitude    "41"
  f.sequence(:email)  { |i| "user_#{i}@popravi.com" }
end

Factory.define :problem1, :class => Problem do |f|
  f.association :category#, :factory => :category1
  f.association :municipality#, :factory => :municipality1
  f.description "Description 1"
  f.photo photo
  f.longitude   "21"
  f.latitude    "41"
  f.sequence(:email)  { |i| "user_#{i}@popravi.com" }
end

Factory.define :problem2, :class => Problem do |f|
  f.association :user
  f.association :category#, :factory => :category2
  f.association :municipality#, :factory => :municipality2
  f.description "Description 2"
  f.photo photo
  f.longitude "22"
  f.latitude "42"
end

Factory.define :problem3, :class => Problem do |f|
  f.association :category#, :factory => :category3
  f.association :municipality#, :factory => :municipality3
  f.description "Description 3"
  f.photo photo
  f.longitude   "23"
  f.latitude    "43"
  f.sequence(:email)  { |i| "user_#{i}@popravi.com" }
end
