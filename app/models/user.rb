class User < ApplicationRecord
  authenticates_with_sorcery!
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :sex, presence: true
  enum sex: { male: 0, female: 1 }
end
