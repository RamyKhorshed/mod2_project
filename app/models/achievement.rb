class Achievement < ApplicationRecord
  has_many :activity_achievements
  has_many :activities, through: :activity_achievements
  has_many :users, through: :activities
end
