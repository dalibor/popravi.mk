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
  has_many :comments

  # Validations
  #validates_presence_of :email, :if => Proc.new { |problem| problem.user_id.blank? && problem.device_id.blank?}
  validates_presence_of :description
  validates_presence_of :longitude
  validates_presence_of :latitude
  validates_presence_of :category
  validates_presence_of :municipality
  #validates_attachment_presence :photo, :if => Proc.new { |problem| problem.device_id.blank? }, :message => "мора да биде зададено"
  validates_inclusion_of :weight, :in => 0..10 # TODO: test

  # Named scopes
  named_scope :with_photo, :conditions => 'problems.photo_file_name IS NOT NULL', :include => [:category, :municipality], :order => "id DESC", :limit => 5
  named_scope :matching, lambda {|column, value| value.blank? ? {} : {:conditions => ["#{column} LIKE ?", "%#{value}%"]} }
  named_scope :with_category, lambda {|category_id| category_id.blank? ? {} : {:conditions => ["problems.category_id = ?", category_id]} }
  named_scope :with_municipality, lambda {|municipality_id| municipality_id.blank? ? {} : {:conditions => ["problems.municipality_id = ?", municipality_id]} }

  attr_accessor :address

  # Callbacks
  after_validation :add_error_on_photo, :validates_longitude_and_latitude

  def title
    "Проблем со #{category.name} во општина #{municipality.name}"
  end


  private
  # formtastic errors fix for paperclip
  def add_error_on_photo
    errors.add(:photo, errors.on(:photo_file_name)) if errors.on(:photo_file_name)
  end

  # formtastic errors fix for longitude and latitude
  def validates_longitude_and_latitude
    errors.add(:base, "Не е означена локацијата на мапа") if errors.on(:latitude) || errors.on(:longitude)
  end

  # Status
  #  0 New
  # -1 Invalid
end
