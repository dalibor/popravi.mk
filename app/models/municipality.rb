class Municipality < ActiveRecord::Base

  # Associations
  belongs_to :region
  has_many :problems
  has_many :users

  # Validations
  validates_presence_of :name

  # Scopes
  scope :ordered, order('name ASC')

  def self.top(limit_count)
    Municipality.find :all,
                      :select => "municipalities.id,
                                  municipalities.name,
                                  COUNT(*) as problems_count",
                      :joins => :problems,
                      :group => "municipalities.id",
                      :limit => limit_count,
                      :order => "problems_count DESC"
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

