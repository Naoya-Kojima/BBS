json.post do
  json.title(@post.title)
  json.content(@post.content)
  json.comments do
    json.array!(@post.comments) do |comment|
      json.content(comment.content)
      if comment.user.present?
        json.user(comment.user, :id, :name)
      else
        json.user(comment.user)
      end
    end
  end
end
