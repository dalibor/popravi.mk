photo = File.open("public/images/rails.png", 'r')

Factory.define :problem do |f|
  f.description 'Problem description'
  f.photo       photo
  f.longitude   '21'
  f.latitude    '41'
  f.association :category
  f.association :municipality
  f.status      'reported'
  f.association :user
end
