class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  
  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15 }, presence: true

  scope :visible_to, -> (user) { user ? all : self.publicly_viewable }

  def self.publicly_viewable
    publicly_viewable_topics = Topic.where(public: true)
    publicly_viewable_topics
  end

  def self.privately_viewable
    privately_viewable_topics = Topic.where(public: false)
    privately_viewable_topics
  end
end