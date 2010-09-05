Factory.define :post do |post|
  post.association :user
  post.title "Hello world 1"
  post.content "Post content"
  post.published_at "2010-01-01"
end
