class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true
  validates :content, presence: true

  def is_commented_by_user?(user)
    if user.present?
      user.id == user_id
    else
      false
    end
  end
end
