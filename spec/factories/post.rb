Factory.define :post do |f|
  f.title        'Hello world 1'
  f.content      'Post content'
  f.published    true
  f.published_at '2010-01-01'
  f.association  :user
end
