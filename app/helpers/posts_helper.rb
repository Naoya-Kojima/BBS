module PostsHelper
  def posted_by_current_user(user)
    current_user == user
  end
end
