Factory.define :comment do |comment|
  comment.association :user
  comment.association :problem, :factory => "problem1"
  comment.content "My comment"
end

Factory.define :anonymous_comment, :class => Comment do |comment|
  comment.association :problem
  comment.content "My anonymous comment"
end
