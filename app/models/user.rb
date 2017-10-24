class User < ApplicationRecord
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :achievements, through: :activities

<<<<<<< HEAD
  has_secure_password
=======
  validates :name, presence: true
  validates :name, uniqueness: true 

>>>>>>> 99650766b65fdd562798deb208158673a1da4b86
end
