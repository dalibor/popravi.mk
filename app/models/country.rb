class Country < ActiveRecord::Base
  # Associations
  has_many :regions

  # Validations
  validates_presence_of :name

  # Scopes
  scope :ordered, order("name ASC")
end
