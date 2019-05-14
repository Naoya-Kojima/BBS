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

  def is_anonymous?
    user_id.nil?
  end

  def can_be_edited_by_user?(user)
    if is_commented_by_user?(user)
      true
    else
      post.is_posted_by_user?(user) && is_anonymous?
    end
  end
end
