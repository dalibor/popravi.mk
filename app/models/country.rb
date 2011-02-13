class Country < ActiveRecord::Base
  # Associations
  has_many :regions

  # Validations
  validates_presence_of :name
end

# == Schema Information
#
# Table name: countries
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

