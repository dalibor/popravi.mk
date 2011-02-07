Factory.define :comment do |comment|
  comment.association :commentable, :factory => "problem"
  comment.content "My comment"
end
