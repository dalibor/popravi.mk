class Municipality < ActiveRecord::Base

  # Associations
  belongs_to :region
  has_many :problems
  has_many :users
  has_many :posts, :through => :users

  # Validations
  validates_presence_of :name

  # Callbacks
  before_save :set_slug

  # Scopes
  scope :ordered, order('name ASC')

  private

    def set_slug
      self.slug = name.to_s.to_lat.parameterize.to_s
    end
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

