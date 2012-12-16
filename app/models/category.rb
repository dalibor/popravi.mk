class Category < ActiveRecord::Base

  acts_as_list

  # Associations
  has_many :problems

  # Validations
  validates_presence_of :name

  # Scopes
  scope :ordered, order("position ASC")
end
