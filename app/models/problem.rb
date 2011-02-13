class Problem < ActiveRecord::Base

  # Paperclip
  has_attached_file :photo, :styles => {:s => '60x60#', :m => '300x300#'},
                  :url  => "/assets/problems/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/problems/:id/:style/:basename.:extension",
                  :default_url => "/images/problems/default_:style.png"

  # Associations
  belongs_to :user, :counter_cache => true
  belongs_to :category
  belongs_to :municipality
  has_many :comments, :as => :commentable

  # Validations
  validates_presence_of :description, :latitude, :longitude, :category_id, :municipality_id
  validates_inclusion_of :weight, :in => 0..10 # TODO: test
  #validates_presence_of :email, :if => Proc.new { |problem| problem.user_id.blank? && problem.device_id.blank?}
  #validates_attachment_presence :photo, :if => Proc.new { |problem| problem.device_id.blank? }, :message => "мора да биде зададено"

  # Scopes
  scope :with_photo, :conditions => 'problems.photo_file_name IS NOT NULL', :include => [:category, :municipality], :order => "id DESC", :limit => 5
  scope :matching, lambda {|column, value| value.blank? ? {} : {:conditions => ["#{column} LIKE ?", "%#{value}%"]} }
  scope :with_category, lambda {|category_id| category_id.blank? ? {} : {:conditions => ["problems.category_id = ?", category_id]} }
  scope :with_municipality, lambda {|municipality_id| municipality_id.blank? ? {} : {:conditions => ["problems.municipality_id = ?", municipality_id]} }

  attr_accessor :address

  # Callbacks
  after_validation :add_error_on_photo, :validates_longitude_and_latitude

  def title
    "Проблем со #{category.name} во општина #{municipality.name}"
  end


  private
  # formtastic errors fix for paperclip
  def add_error_on_photo
    self.errors[:photo] << errors[:photo_file_name] if errors[:photo_file_name].present?
  end

  # formtastic errors fix for longitude and latitude
  def validates_longitude_and_latitude
    self.errors[:base] << "Не е означена локацијата на мапа" if errors[:latitude].present? || errors[:longitude].present?
  end

  # Status
  #  0 New
  # -1 Invalid
end

# == Schema Information
#
# Table name: problems
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  category_id        :integer(4)
#  municipality_id    :integer(4)
#  description        :text
#  status             :integer(4)      default(0)
#  longitude          :string(255)
#  latitude           :string(255)
#  email              :string(255)
#  device_id          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer(4)
#  photo_updated_at   :datetime
#  weight             :integer(4)      default(5)
#

