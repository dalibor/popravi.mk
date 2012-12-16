FactoryGirl.define do
  factory :attachment do
    name 'Attachment1'
    attachment { File.open(File.join(Rails.root, "/spec/fixtures/rails1.png"))  }
    association :user
  end
end
