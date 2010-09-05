Factory.define :comment do |comment|
  comment.association :user
  comment.association :commentable, :factory => "problem1"
  comment.content "My comment"
end

Factory.define :anonymous_comment, :class => Comment do |comment|
  comment.association :commentable, :factory => "problem"
  comment.content "My anonymous comment"
end
