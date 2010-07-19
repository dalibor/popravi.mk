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

  # Validations
  validates_presence_of :name, :if => Proc.new { |problem| problem.user_id.blank? }
  validates_presence_of :email, :if => Proc.new { |problem| problem.user_id.blank? }
  validates_presence_of :description
  validates_presence_of :longitude
  validates_presence_of :latitude
  validates_presence_of :category_id
  validates_presence_of :municipality_id
  validates_attachment_presence :photo, :if => Proc.new { |problem| problem.device_id.blank? }

  attr_accessor :address

  # Status
  #  0 New
  # -1 Invalid
end
