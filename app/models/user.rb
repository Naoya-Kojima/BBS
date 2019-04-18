class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :sex, presence: true
  enum sex: { male: 0, female: 1 }
end
