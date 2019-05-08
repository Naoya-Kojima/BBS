class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true

  def is_posted_by_user?(user)
    if user.present?
      user.id == user_id
    else
      false
    end
  end
end
