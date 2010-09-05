Given /^posts exists$/ do
  user = User.first
  post = user ? Factory.create(:post, :user => user) : Factory.create(:post) # if there is already user in db, assign that user
  Factory.create(:post, :user => post.user, :published_at => "2010-03-01", :title => "Hello world 2")
end

Given /^there are no posts/ do
  Post.count == 0
end
