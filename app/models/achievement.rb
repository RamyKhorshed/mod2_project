class Achievement < ApplicationRecord
  has_many :activity_achievements
  has_many :activities, through: :activity_achievements
  has_many :user_achievements
  has_many :users, through: :user_achievements
end
