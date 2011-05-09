class Municipality < ActiveRecord::Base

  # Associations
  belongs_to :region
  has_one :contact
  has_many :problems
  has_many :users
  has_many :posts, :through => :users

  # Paperclip
  has_attached_file :photo, :styles => {:xs => '13x13#', :s => '60x60#', :m => '300x300#'},
                  :url  => "/assets/municipalities/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/municipalities/:id/:style/:basename.:extension",
                  :default_url => "/images/municipalities/default_:style.png"


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

