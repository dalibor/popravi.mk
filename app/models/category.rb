class Category < ActiveRecord::Base
  # Associations
  has_many :problems

  # Validations
  validates_presence_of :name
end
