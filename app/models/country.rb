class Country < ActiveRecord::Base
  # Associations
  has_many :regions

  # Validations
  validates_presence_of :name
end
