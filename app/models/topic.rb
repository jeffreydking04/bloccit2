class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  
  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15 }, presence: true

  scope :visible_to, -> (user) { user ? all : self.publicly_viewable }

  def self.publicly_viewable
    Topic.where(public: true)
  end

  def self.privately_viewable
    Topic.where(public: false)
  end
end