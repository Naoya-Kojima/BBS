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

  def post_is_created_by_user?(user)
    (post.user == user) && user_id.nil?
  end
end

コメントのポスト作成ユーザーが一致
