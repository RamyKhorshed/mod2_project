class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :user_achievements
  has_many :achievements, through: :user_achievements


  has_secure_password

  validates :name, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :username, presence: true
  validates :username, uniqueness: true

# after_initialize :set_achievements_list
#
# def set_achievements_list
#   @achievements_list = []
# end




end
