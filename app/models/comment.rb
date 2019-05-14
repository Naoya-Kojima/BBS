class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true
  validates :content, presence: true

  def can_be_edited_by_user?(user)
    if user.present?
      (user.id == user_id) || ((post.user == user) && user_id.nil?)
    else
      false
    end
  end
end
