photo = File.open("public/images/rails.png", 'r')

Factory.define :problem do |problem|
  problem.association :user
  problem.association :category
  problem.association :municipality
  problem.subject "Problem subject"
  problem.description "Problem description"
  problem.photo photo
  problem.longitude "21"
  problem.latitude "41"
end

Factory.define :anonymous_problem, :class => Problem do |problem|
  problem.association :category
  problem.association :municipality
  problem.subject "Problem subject"
  problem.description "Problem description"
  problem.photo photo
  problem.longitude "21"
  problem.latitude "41"
  problem.name "Test User"
  problem.email "test_user@popravi.mk"
end

Factory.define :problem1, :class => Problem do |problem|
  problem.association :category, :factory => :category1
  problem.association :municipality, :factory => :municipality1
  problem.subject "Subject 1"
  problem.description "Description 1"
  problem.photo photo
  problem.longitude "21"
  problem.latitude "41"
  problem.name "Test User"
  problem.email "test_user@popravi.mk"
end

Factory.define :problem2, :class => Problem do |problem|
  problem.association :user
  problem.association :category, :factory => :category2
  problem.association :municipality, :factory => :municipality2
  problem.subject "Subject 2"
  problem.description "Description 2"
  problem.photo photo
  problem.longitude "22"
  problem.latitude "42"
end

Factory.define :problem3, :class => Problem do |problem|
  problem.association :category, :factory => :category3
  problem.association :municipality, :factory => :municipality3
  problem.subject "Subject 3"
  problem.description "Description 3"
  problem.photo photo
  problem.longitude "23"
  problem.latitude "43"
  problem.name "Test User"
  problem.email "test_user@popravi.mk"
end
