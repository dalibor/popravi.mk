class Post < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :comments, :as => :commentable

  # Validations
  validates_presence_of :user_id, :title, :content

  # Attributes
  attr_accessor :custom_slug
  attr_writer :publish

  # Callbacks
  before_validation :set_slug
  before_save :set_published_at

  # Scopes
  scope :published, :conditions => 'published_at IS NOT NULL', :order => 'published_at DESC'
  scope :for_month, lambda {|year, month|
    if !month.blank? && !year.blank?
      start_time = Time.mktime(year, month, nil)
      {:conditions => ["published_at BETWEEN ? AND ?", start_time, start_time.next_month]}
    else
      {}
    end
  }

  def publish
    @publish || !published_at.nil?
  end

  def self.archive_items
    find(:all, :select => "published_at", :conditions => "published_at IS NOT NULL").collect{|a| [a.published_at.year, a.published_at.month]}.uniq || []
  end

  def to_param
    slug
  end

  private

  def set_slug
    if custom_slug == "1"
      self.slug = slug.to_s.to_lat.parameterize.to_s
    else
      self.slug = title.to_s.to_lat.parameterize.to_s
    end
  end

  def set_published_at
    if publish == "1"
      self.published_at = Time.now if published_at_was == nil
    elsif publish == "0"
      self.published_at = nil
    end
  end
end
