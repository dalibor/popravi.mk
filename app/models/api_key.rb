class ApiKey < ActiveRecord::Base

  # Attributes
  has_many :problems

  # Scopes
  scope :ordered, order("name ASC")

  # Validations
  validates :name, presence: true
  validates :key, presence: true
  validates :description, presence: true
end
