class Post < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :comments, :as => :commentable

  # Attributes
  attr_accessor :custom_slug

  # Validations
  validates_presence_of :user_id, :title, :content

  # Callbacks
  before_validation :set_slug
  before_save :set_published_at

  # Scopes
  scope :published, where(['published = ?', true])
  scope :from_admins, joins(:user).where(['users.is_admin = ?', true])
  scope :ordered, order('published_at DESC')
  scope :for_month, lambda {|year, month|
    if !month.blank? && !year.blank?
      start_time = Time.mktime(year, month, nil)
      {:conditions => ["published_at BETWEEN ? AND ?", start_time, start_time.next_month]}
    else
      {}
    end
  }

  def self.archive_items
    select("published_at").where("published_at IS NOT NULL").
      collect{|a| [a.published_at.year, a.published_at.month]}.uniq || []
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
      if (new_record? || published_changed?)
        self.published_at = published ? Time.now : nil
      end
    end
end
