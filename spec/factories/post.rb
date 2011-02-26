Factory.define :post do |post|
  post.title        "Hello world 1"
  post.content      "Post content"
  post.published    true
  post.published_at "2010-01-01"
  post.association  :user
end
