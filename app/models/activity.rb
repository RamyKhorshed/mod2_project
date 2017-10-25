class Activity < ApplicationRecord
  has_many :user_activities
  has_many :users, through: :user_activities
  has_many :activity_achievements
  has_many :achievements, through: :activity_achievements

  validates :name, presence: {message: "needs a name"}
  validates :category, presence: {message: "needs a category"}
end
