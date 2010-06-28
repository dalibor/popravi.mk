class Region < ActiveRecord::Base
  # Associations
  has_many :municipalities
  belongs_to :country

  # Validations
  validates_presence_of :name
end
