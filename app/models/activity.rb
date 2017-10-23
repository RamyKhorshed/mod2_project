class Activity < ApplicationRecord
  has_many :user_activities
  has_many :users, through: :user_activities
  has_many :activity_achievements
  has_many :achievements, through: :activity_achievements
end
