class ApiKey < ActiveRecord::Base

  # Attributes
  has_many :problems

  # Scopes
  scope :ordered, order("name ASC")
end
