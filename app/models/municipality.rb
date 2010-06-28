class Municipality < ActiveRecord::Base
  # Associations
  has_many :problems
  belongs_to :region

  # Validations
  validates_presence_of :name
end
