Factory.define :comment do |f|
  f.association :commentable, :factory => 'problem'
  f.content     'My comment'
end
