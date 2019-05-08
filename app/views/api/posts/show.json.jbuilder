json.post do
  json.title(@post.title)
  json.content(@post.content)
  json.comments do
    json.array!(@post.comments) do |comment|
      json.content(comment.content)
      json.user do
        json.user_id comment.user_id

        if comment.user_id.present?
          json.name User.find_by(id: comment.user_id).name
        else
          json.name comment.user_id
        end
      end
    end
  end
end
