class Municipality < ActiveRecord::Base
  # Associations
  has_many :problems
  belongs_to :region

  # Validations
  validates_presence_of :name
end

# == Schema Information
#
# Table name: municipalities
#
#  id         :integer(4)      not null, primary key
#  region_id  :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

