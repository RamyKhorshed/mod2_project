class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :achievements, through: :activities


  has_secure_password

  validates :name, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :username, presence: true
  validates :username, uniqueness: true

end
