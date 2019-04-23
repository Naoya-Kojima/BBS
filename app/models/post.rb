class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
end
