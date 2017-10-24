class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :achievements, through: :activities

  validates :name, presence: true
  validates :name, uniqueness: true 

end
