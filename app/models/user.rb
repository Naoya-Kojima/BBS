class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :posts
  has_many :comments
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true
  validates :sex, presence: true
  enum sex: { male: 0, female: 1 }
end
