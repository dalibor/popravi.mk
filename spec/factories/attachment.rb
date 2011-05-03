Factory.define :attachment, :class => Attachment do |f|
  f.name       { 'Attachment1' }
  f.attachment { File.open(File.join(Rails.root, "/spec/fixtures/rails1.png"))  }
  f.user       { Factory(:user) }
end
