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
  scope :with_photo,
    where('problems.photo_file_name IS NOT NULL').
    includes([:category, :municipality]).
    order("id DESC").
    limit(5)
  scope :matching, lambda {|column, value|
    where(["#{column} LIKE ?", "%#{value}%"]) if value.present?
  }
  scope :with_category, proc {|category_id|
    where(["problems.category_id = ?", category_id]) if category_id.present?
  }
  scope :with_municipality, proc {|municipality_id|
    where(["problems.municipality_id = ?", municipality_id]) if municipality_id.present?
  }
  scope :with_month, proc {|month|
    where(["MONTH(problems.created_at) = ?", month]) if month.present?
  }
  scope :with_year, proc {|year|
    where(["YEAR(problems.created_at) = ?", year]) if year.present?
  }
  scope :unsent, where(["sent_at IS NULL"])
  scope :sent, where(["sent_at IS NOT NULL"])
  scope :filter, proc {|filter|
    if filter == 'unsent'
      unsent
    elsif filter == 'sent'
      sent
    end
  }

  attr_accessor :address

  # Callbacks
  after_validation :add_error_on_photo, :validates_longitude_and_latitude

  def title
    "#{municipality.name} #{category.name}"
  end

  def self.search(params)
    matching(:description, params[:q]).
      with_category(params[:c]).
      with_municipality(params[:m]).
      with_month(params[:month]).
      with_year(params[:year]).
      order('created_at DESC').
      includes([:category, :municipality]).
      paginate :per_page => 10, :page => params[:page]
  end

  def self.years
    Problem.select("YEAR(created_at) as year").group("year").order("year ASC").map{|p| p.year}
  end

  def self.send_problems!
    problems_by_municipality = unsent.includes([{:municipality => :users}, :category]).
                               group_by{|p| p.municipality }

    problems_by_municipality.each do |municipality, problems|
      if municipality.users.present?
        MunicipalityMailer.send_problems(municipality, problems).deliver

        problems.each do |problem|
          problem.sent_at = Time.now
          problem.save
        end
      end
    end
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

