class Region < ActiveRecord::Base
  # Associations
  has_many :municipalities
  belongs_to :country

  # Validations
  validates_presence_of :name
end

# == Schema Information
#
# Table name: regions
#
#  id         :integer(4)      not null, primary key
#  country_id :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

